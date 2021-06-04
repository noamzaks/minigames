import SwiftUI

enum Resource: Int, Identifiable, CaseIterable {
    var id: Int { rawValue }
    
    case lumber
    case brick
    case grain
    case wool
    case ore
}
