import SwiftUI

enum Resource: Int, Identifiable, CaseIterable {
    var id: Int { rawValue }
    
    case lumber
    case brick
    case grain
    case wool
    case ore
    
    // this is ui related therefore, it should not be here
    var icon: String {
        switch self {
        case .lumber:   return "🪵"
        case .brick:    return "🧱"
        case .grain:    return "🌾"
        case .wool:     return "🐑"
        case .ore:      return "🪨"
        }
    }
    
    var matchedColor: UIColor {
        switch self {
        case .lumber:   return UIColor(red: 80, green: 50, blue: 50, alpha: 255)
        case .brick:    return UIColor(red: 230, green: 120, blue: 110, alpha: 255)
        case .grain:    return UIColor(red: 230, green: 200, blue: 110, alpha: 255)
        case .wool:     return UIColor(red: 40, green: 170, blue: 40, alpha: 255)
        case .ore:      return UIColor(red: 120, green: 120, blue: 120, alpha: 255)
        }
    }
    
}
