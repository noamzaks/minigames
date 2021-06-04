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
       
        let R: Float = 1 // changing this from 1 will cause some problems in `Path` implementation
        let tileHeight: Float = 2 * R
        let tileWidth: Float = 2 * cos(Float.pi / 6) * R
        
        // find the vector from the middle to the center of the tile.
        let mid2Tile: SIMD2<Float> = .init(x: Float(tile.column - Intersection.boardMidPosition.column) * tileWidth,
                                           y: Float(Intersection.boardMidPosition.row - tile.row) * tileHeight)
        
        let tile2intersection: SIMD2<Float> = self.tileCorner.vector * R
        
        return tile2intersection + mid2Tile
    }
    
    static func == (lhs: Intersection, rhs: Intersection) -> Bool {
        lhs.boardPosition() == rhs.boardPosition()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.boardPosition())
    }
    
}
