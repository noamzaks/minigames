import Foundation

enum Building{
    case city(intersection: Intersection,       owner: Player)
    case settelment(intersection: Intersection, owner: Player)
    case road(path: RoadPath,                   owner: Player)
        
    var position: SIMD2<Float> {
        switch self {
        case .city(let intersection, _), .settelment(let intersection, _):  return intersection.boardPosition()
        case .road(let roadPath, _):                                        return roadPath.boardPosition()
        }
    }
    
    var angle: Double {
        switch self {
        case .city(_, _), .settelment(_, _):  return 0
        case .road(let roadPath, _):          return Double(roadPath.angle)
        }
    }
}

extension Building: Hashable {
    
}
