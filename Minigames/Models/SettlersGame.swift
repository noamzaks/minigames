import Foundation

class SettlersGame: ObservableObject {
    private(set) var tiles: [Tile]
    private(set) var bank: [Resource]
    @Published private(set) var players: [Player]
    @Published private(set) var gameState: SettlersGameState
    
    convenience init(for players: Int) {
        let nicknames = Array(1...players).map { "player \($0)" }
        self.init(for: nicknames)
    }
    
    init(for nicknames: [String]) {
        self.players = nicknames.map { Player($0, SettlersGame.playerInitialResources) }
        self.bank = SettlersGame.bankInitialResources
        self.tiles = []
        self.gameState = .playerTurn(playerIndex: 0)
        
        
    }
    
//    mutating func transfer(_ resources: [Resource: UInt], from one: UInt, to two: UInt) -> Bool {
//        if hands[one] < resources { return false }
//
//        hands[one] += hands[two]
//        return true
//    }
//
//    mutating func build(_ building: Building, for player: UInt, at tile: UInt, on side: UInt) -> Bool {
//        let currentBuilding = tiles[tile].buildings[side]
//        if building == .city && currentBuilding != nil, currentBuilding! != player { return false }
//
//        // TODO: Check if user is allowed to build at location
//
//        if hands[player] < BuildingCost.of(building) { return false }
//
//        // FIXME
//        // tiles[tile].buildings[side] = player
//
//        return true
//    }
//
//    struct BuildingCost {
//        static let road = ResourceSet(from: [
//            .lumber: 1,
//            .brick: 1,
//        ])
//
//        static let settlement = ResourceSet(from: [
//            .lumber: 1,
//            .brick: 1,
//            .grain: 1,
//            .wool: 1,
//        ])
//
//        static let city = ResourceSet(from: [
//            .grain: 2,
//            .ore: 3,
//        ])
//
//        static let development = ResourceSet(from: [
//            .grain: 1,
//            .wool: 1,
//            .ore: 1,
//        ])
//
//        static func of(_ building: Building) -> ResourceSet {
//            switch(building) {
//            case .road:
//                return road
//            case .settlement:
//                return settlement
//            case .city:
//                return city
//            }
//        }
//    }
//
//    enum Building {
//        case road
//        case settlement
//        case city
//    }
    
    //MARK: constants
    
    private static let playerInitialResources: [Resource] = {
        var resources = Array<Resource>()
        resources.append(contentsOf: repeatElement(Resource.lumber  , count: 4))
        resources.append(contentsOf: repeatElement(Resource.brick   , count: 3))
        resources.append(contentsOf: repeatElement(Resource.grain   , count: 4))
        resources.append(contentsOf: repeatElement(Resource.wool    , count: 4))
        resources.append(contentsOf: repeatElement(Resource.ore     , count: 3))
        return resources
    }()
    
    private static let bankInitialResources: [Resource] = {
        var resources = Array<Resource>()
        resources.append(contentsOf: repeatElement(Resource.lumber  , count: 4))
        resources.append(contentsOf: repeatElement(Resource.brick   , count: 3))
        resources.append(contentsOf: repeatElement(Resource.grain   , count: 4))
        resources.append(contentsOf: repeatElement(Resource.wool    , count: 4))
        resources.append(contentsOf: repeatElement(Resource.ore     , count: 3))
        return resources
    }()
    
    private static let boardTerrains: [Terrain] = {
        var tiles = Array<Terrain>()
        tiles.append(contentsOf: repeatElement(Terrain.desert   , count: 1))
        tiles.append(contentsOf: repeatElement(Terrain.pasture  , count: 4))
        tiles.append(contentsOf: repeatElement(Terrain.fields   , count: 4))
        tiles.append(contentsOf: repeatElement(Terrain.mountains, count: 3))
        tiles.append(contentsOf: repeatElement(Terrain.forest   , count: 4))
        tiles.append(contentsOf: repeatElement(Terrain.hills    , count: 3))
        return tiles
    }()
    
    private static let boardDiceValues: [(value: Int, probability: Int)] = {
        var values = Array<(value: Int, probability: Int)>()
        values.append(contentsOf: repeatElement((value: 2   , probability: 1), count: 1))
        values.append(contentsOf: repeatElement((value: 3   , probability: 2), count: 2))
        values.append(contentsOf: repeatElement((value: 4   , probability: 3), count: 2))
        values.append(contentsOf: repeatElement((value: 5   , probability: 4), count: 2))
        values.append(contentsOf: repeatElement((value: 6   , probability: 5), count: 2))
        values.append(contentsOf: repeatElement((value: 8   , probability: 5), count: 2))
        values.append(contentsOf: repeatElement((value: 9   , probability: 4), count: 2))
        values.append(contentsOf: repeatElement((value: 10  , probability: 3), count: 2))
        values.append(contentsOf: repeatElement((value: 11  , probability: 2), count: 2))
        values.append(contentsOf: repeatElement((value: 12  , probability: 1), count: 1))
        return values
    }()
    
    private static let minAmountOfColumns: Int = 3
    private static let maxAmountOfColumns: Int = 5

    private static let boardPosition: [(row: Int, column: Int)] = {
        var positions = Array<(row: Int, column: Int)>()
        
        let numberOfRows = (maxAmountOfColumns - minAmountOfColumns) * 2 + 1
        var currentAmountOfColumns: Int = minAmountOfColumns
        var maxAmountOfColumnsAchived: Bool = false
        for row in 0..<numberOfRows {
            for column in 0..<currentAmountOfColumns {
                positions.append((row, column))
            }
            currentAmountOfColumns += maxAmountOfColumnsAchived ? -1 : 1
            if currentAmountOfColumns == maxAmountOfColumns {
                maxAmountOfColumnsAchived = true
            }
        }
        
        return positions
    }()
    
    
}
