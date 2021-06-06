import Foundation

enum Building{
    case city(intersection: Intersection)
    case settelment(intersection: Intersection)
    case road(path: RoadPath)
    
    var position: SIMD2<Float> {
        switch self {
        case .city(let intersection), .settelment(let intersection):    return intersection.boardPosition()
        case .road(let roadPath):                                       return roadPath.boardPosition()
        }
    }
    
    var angle: Double {
        switch self {
        case .city(_), .settelment(_):  return 0
        case .road(let roadPath):       return Double(roadPath.angleRelativeToX)
        }
    }
}

extension Building: Hashable {
    
}
