import Foundation

class Tile: ObservableObject {
    
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
}
