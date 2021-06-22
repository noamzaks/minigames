import Foundation

enum Building: BoardPosition{
    case city(intersection: Intersection,       owner: Player)
    case settelment(intersection: Intersection, owner: Player)
    case road(path: RoadPath,                   owner: Player)
    
    var angle: Double {
        switch self {
        case .city(_, _), .settelment(_, _):  return 0
        case .road(let roadPath, _):          return Double(roadPath.angle)
        }
    }
    
    func boardPosition() -> SIMD2<Float> {
        switch self {
        case .city(let intersection, _), .settelment(let intersection, _):  return intersection.boardPosition()
        case .road(let roadPath, _):                                        return roadPath.boardPosition()
        }
    }
}

extension Building: Hashable {
    
}
