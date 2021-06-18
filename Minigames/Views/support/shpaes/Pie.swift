//
//  Pie.swift
//  Minigames
//
//  Created by Tomer Israeli on 15/06/2021.
//

import SwiftUI

struct Pie: Shape {
    
    var startAngle: Angle
    var endAngle: Angle
    
    var clockwise: Bool = true
    
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(startAngle.radians, endAngle.radians)
        }
        set{
            startAngle = Angle.radians(newValue.first)
            endAngle = Angle.radians(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        
        let radius: CGFloat = min(rect.width, rect.height)/2
        let center: CGPoint = .init(x: rect.midX, y: rect.midY)
        let start: CGPoint = .init(
            x: center.x + cos(CGFloat(startAngle.radians) * radius),
            y: center.y + sin(CGFloat(startAngle.radians) * radius))
        
        var path = Path()
        path.move(to: center)
        path.addLine(to: start)
        path.addArc(center: center,
                    radius: radius,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: clockwise)
        path.addLine(to: center)
        return path
    }
}
