//
//  TileCorner.swift
//  Minigames
//
//  Created by Tomer Israeli on 04/06/2021.
//

import Foundation

enum TileCorner: CaseIterable {
    case top
    case topRight
    case bottomRight
    case bottom
    case bottomLeft
    case topLeft
    
    var angleRelativeToXAxes: Double {
        switch self {
        case .topRight:     return 1  * TileCorner.deg30InRad
        case .top:          return 3  * TileCorner.deg30InRad
        case .topLeft:      return 5  * TileCorner.deg30InRad
        case .bottomLeft:   return 7  * TileCorner.deg30InRad
        case .bottom:       return 9  * TileCorner.deg30InRad
        case .bottomRight:  return 11 * TileCorner.deg30InRad
        }
    }
     
    // the vector from the tile center to the corner assuming the radius is 1
    var vector: SIMD2<Float> {
        .init(x: Float(cos(self.angleRelativeToXAxes)),
              y: Float(sin(self.angleRelativeToXAxes)))
    }
    
    private static let deg30InRad: Double = Double.pi / 6

}
