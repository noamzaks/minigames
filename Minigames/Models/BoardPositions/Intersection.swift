//
//  Intersection.swift
//  Minigames
//
//  Created by Tomer Israeli on 04/06/2021.
//

import Foundation

struct Intersection: BoardPosition {
    var tile: Tile
    var tileCorner: TileCorner
        
    init(on tile: Tile, at corner: TileCorner, isHarbor: Bool = false) {
        self.tile = tile
        self.tileCorner = corner
    }
    
}

extension Intersection: Hashable, Equatable {

    // find the intersection relative position to middle tile of the board
    // assuming the radius ot the blocking circle of the hexagon is 1
    func boardPosition() -> SIMD2<Float> {
        tile.boardPosition() + self.tileCorner.vector
    }
    
    static func == (lhs: Intersection, rhs: Intersection) -> Bool {
        lhs.boardPosition() == rhs.boardPosition()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.boardPosition())
    }
    
}
