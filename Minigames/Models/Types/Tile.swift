import Foundation

class Tile: ObservableObject, BoardPosition, Equatable {
    
    var terrain: Terrain
    var diceValue: (value: Int, probability: Int)?
    var row: Int
    var column: Int
    @Published var knightIsIn: Bool
    
    init(terrain: Terrain, dice diceValue: (value: Int, probability: Int)?, row: Int, column: Int, knightIsIn: Bool = false) {
        self.terrain = terrain
        self.diceValue = diceValue
        self.row = row
        self.column = column
        self.knightIsIn = knightIsIn
    }
    
    func boardPosition() -> SIMD2<Float> {
        
        let R: Float = 1 // changing this from 1 will cause some problems in the game implementation
        let tileHeight: Float = 1.5 * R
        let tileWidth: Float
        if self.row % 2 == 0 {
            tileWidth = 2 * cos(Float.pi / 6) * R
        } else {
            tileWidth = cos(Float.pi / 6) * R
        }
        
        
        // find the vector from the middle to the center of the tile.
        return .init(x: Float(self.column - Intersection.boardMidPosition.column) * tileWidth,
                     y: Float(Intersection.boardMidPosition.row - self.row) * tileHeight)
        
    }
    
    static func == (lhs: Tile, rhs: Tile) -> Bool {
        lhs.row == rhs.row && lhs.column == rhs.column
    }
    
    static func == (lhs: Tile, rhs: (row: Int, column: Int)?) -> Bool {
        guard let rhs = rhs else { return false }
        return lhs.row == rhs.row && lhs.column == rhs.column
    }
    
}
