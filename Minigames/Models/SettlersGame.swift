import Foundation

struct SettlersGame {
    let tiles: [Tile]
    private(set) var hands: [ResourceSet]
    private(set) var bank = ResourceSet()
    var turn: UInt
    
    init(for players: UInt) {
        turn = 0
        
        for resource in Resource.allCases {
            bank.add(19, of: resource)
        }
        
        hands = [ResourceSet](repeating: ResourceSet(), count: Int(players))
        
        let resources = SettlersGame.initialResources.shuffled()
        let dice = SettlersGame.initialDice.shuffled()
        
        tiles = (0..<SettlersGame.initialResources.count).map { index in
            Tile(resource: resources[index], dice: dice[index])
        }
    }
    
    mutating func transfer(_ resources: [Resource: UInt], from one: UInt, to two: UInt) -> Bool {
        if hands[one] < resources { return false }
        
        hands[one] += hands[two]
        return true
    }
    
    mutating func build(_ building: Building, for player: UInt, at tile: UInt, on side: UInt) -> Bool {
        let currentBuilding = tiles[tile].buildings[side]
        if building == .city && currentBuilding != nil, currentBuilding! != player { return false }
        
        // TODO: Check if user is allowed to build at location
        
        if hands[player] < BuildingCost.of(building) { return false }
        
        // FIXME
        // tiles[tile].buildings[side] = player
        
        return true
    }
    
    struct BuildingCost {
        static let road = ResourceSet(from: [
            .lumber: 1,
            .brick: 1,
        ])
        
        static let settlement = ResourceSet(from: [
            .lumber: 1,
            .brick: 1,
            .grain: 1,
            .wool: 1,
        ])
        
        static let city = ResourceSet(from: [
            .grain: 2,
            .ore: 3,
        ])
        
        static let development = ResourceSet(from: [
            .grain: 1,
            .wool: 1,
            .ore: 1,
        ])
        
        static func of(_ building: Building) -> ResourceSet {
            switch(building) {
            case .road:
                return road
            case .settlement:
                return settlement
            case .city:
                return city
            }
        }
    }
    
    enum Building {
        case road
        case settlement
        case city
    }
    
    private static let initialResources: [Resource] = [.lumber, .lumber, .lumber, .lumber, .brick, .brick, .brick, .grain, .grain, .grain, .grain, .wool, .wool, .wool, .wool, .ore, .ore, .ore]
    private static let initialDice: [UInt] = [2, 3, 3, 4, 4, 5, 5, 6, 6, 8, 8, 9, 9, 10, 10, 11, 11, 12]
}
