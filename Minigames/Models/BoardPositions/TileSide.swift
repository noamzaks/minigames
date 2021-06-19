//
//  TileSide.swift
//  Minigames
//
//  Created by Tomer Israeli on 18/06/2021.
//

import Foundation

enum TileSide: CaseIterable {
    case topRight
    case right
    case bottomRight
    case bottomLeft
    case left
    case topLeft
    
    // to center of side
    var angleRelativeToXAxes: Double {
        switch self {
        case .topRight:     return 1 * TileSide.deg60InRad
        case .right:        return 0
        case .bottomRight:  return 5 * TileSide.deg60InRad
        case .bottomLeft:   return 4 * TileSide.deg60InRad
        case .left:         return 3 * TileSide.deg60InRad
        case .topLeft:      return 2 * TileSide.deg60InRad
        }
    }
     
    // the vector from the tile center to the corner assuming the radius is 1
    var vector: SIMD2<Float> {
        let R: Float = 1
        let H: Float = sqrt(pow(R, 2) - pow(0.5 * R, 2))
            
        return .init(x: Float(cos(self.angleRelativeToXAxes)) * H,
                     y: Float(sin(self.angleRelativeToXAxes)) * H
        )
    }
    
    private static let deg60InRad: Double = Double.pi / 3

}
