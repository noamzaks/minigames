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
        let tileWidth: Float = 2 * cos(Float.pi / 6) * R
        
        // find the vector from the middle to the center of the tile.
        return .init(x: (Float(self.column) - self.midColumn(row: row)) * tileWidth,
                     y: Float(self.midRow - self.row) * tileHeight)
        
    }
    
    private func midColumn(row: Int) -> Float{
        let dRow: Float = .init(abs(row - self.midRow))
        return Float(self.midColumn) - dRow * 0.5
    }
    
    public var gridPosition: (row: Int, column: Int) { (row, column) }
    
    static func == (lhs: Tile, rhs: Tile) -> Bool {
        lhs.row == rhs.row && lhs.column == rhs.column
    }
    
    static func == (lhs: Tile, rhs: (row: Int, column: Int)?) -> Bool {
        guard let rhs = rhs else { return false }
        return lhs.row == rhs.row && lhs.column == rhs.column
    }
    
}
