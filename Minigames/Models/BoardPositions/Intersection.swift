//
//  Intersection.swift
//  Minigames
//
//  Created by Tomer Israeli on 04/06/2021.
//

import Foundation

class Intersection: BoardPosition {
    var owner: Player?
    
    var tile: Tile
    var tileCorner: TileCorner
    var isHarbor: Bool = false
        
    init(on tile: Tile, at corner: TileCorner, isHarbor: Bool = false) {
        self.tile = tile
        self.tileCorner = corner
        self.isHarbor = isHarbor
    }
    
    static var boardMidPosition: (row: Int, column: Int) = (2,2)
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
