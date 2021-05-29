import SwiftUI

struct Hexagon: Shape {
    private static let margin = 0.2
    
    func path(in rect: CGRect) -> Path {
        let size = Double(min(rect.size.height, rect.size.width))
        var p = Path()
        
        p.move(to: CGPoint(x: 0, y: size * (1.0 - Hexagon.margin)))
        p.addLine(to: CGPoint(x: size / 2, y: size))
        p.addLine(to: CGPoint(x: size, y: size * (1.0 - Hexagon.margin)))
        p.addLine(to: CGPoint(x: size, y: size * Hexagon.margin))
        p.addLine(to: CGPoint(x: size / 2, y: 0))
        p.addLine(to: CGPoint(x: 0, y: size * Hexagon.margin))
        p.addLine(to: CGPoint(x: 0, y: size * (1.0 - Hexagon.margin)))
        
        return p
    }
}
