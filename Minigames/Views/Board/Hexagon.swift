import SwiftUI

struct Hexagon: Shape {
    
    var baseAngle: CGFloat = 30
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let R = min(rect.height, rect.width)/2
        
        p.move(to: getPoint(angle: 0, radius: R, at: rect))
        
        for k in 1...6 {
            p.addLine(to: getPoint(angle: CGFloat(k * 60), radius: R, at: rect))
        }
        return p
    }
    
    private func getPoint(angle: CGFloat, radius R: CGFloat, at rect: CGRect) -> CGPoint{
        let angleRad = (baseAngle + angle) * CGFloat.pi / 180
        
        return CGPoint(x: R * cos(angleRad) + rect.midX, y: R * sin(angleRad) + rect.midY)
    }
}
