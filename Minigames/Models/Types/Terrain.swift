
import Foundation

enum Terrain {
    case forest
    case hills
    case fields
    case pasture
    case mountains
    case desert

    var resource: Resource? {
        switch self {
        case .forest:       return .lumber
        case .hills:        return .brick
        case .fields:       return .grain
        case .pasture:      return .wool
        case .mountains:    return .ore
        case .desert:       return nil
        }
    }
}
