//
//  Path.swift
//  Minigames
//
//  Created by Tomer Israeli on 04/06/2021.
//

import Foundation
import simd

class RoadPath: BoardPosition {
    
    private var tileSide: TileSide
    private var tile: Tile
    
    init(on tile: Tile, at tileSide: TileSide) {
        self.tileSide = tileSide
        self.tile = tile
    }
    
    var angle: Double { Double.pi/2 - self.tileSide.angleRelativeToXAxes }

}

extension RoadPath: Hashable, Equatable {
    
    // find the path center relative to the middle tile of the board
    func boardPosition() -> SIMD2<Float>{
        tile.boardPosition() + tileSide.vector
    }
    
    static func == (lhs: RoadPath, rhs: RoadPath) -> Bool {
        lhs.boardPosition() == rhs.boardPosition()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.boardPosition())
    }
}
