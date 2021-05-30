import SwiftUI

enum Resource: Int, Identifiable, CaseIterable {
    var id: Int { rawValue }
    
    case lumber = 0
    case brick = 1
    case grain = 2
    case wool = 3
    case ore = 4
    
    static let icons: [String] = ["🪵", "🧱", "🌾", "🐑", "🪨"]
    
    static let colors: [Color] = [
        Color(red: 80, green: 50, blue: 50),
        Color(red: 230, green: 120, blue: 110),
        Color(red: 230, green: 200, blue: 110),
        Color(red: 40, green: 170, blue: 40),
        Color(red: 120, green: 120, blue: 120),
    ]
}
