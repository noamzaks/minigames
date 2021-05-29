import Foundation

struct SettlersGame {
    let tiles: [Tile]
    private(set) var hands: [[Resource: UInt]]
    private(set) var bank = [Resource: UInt]()
    var turn: UInt
    
    init(for players: UInt) {
        turn = 0
        
        var emptyHand = [Resource: UInt]()
        
        for resource in Resource.allCases {
            bank[resource] = 19
            emptyHand[resource] = 0
        }
        
        hands = [[Resource: UInt]](repeating: emptyHand, count: Int(players))
        
        let resources = SettlersGame.initialResources.shuffled()
        let dice = SettlersGame.initialDice.shuffled()
        
        tiles = (0..<SettlersGame.initialResources.count).map { index in
            Tile(resource: resources[index], dice: dice[index])
        }
    }
    
    mutating func transfer(_ resources: [Resource: UInt], from one: UInt, to two: UInt) -> Bool {
        for (resource, count) in resources {
            if hands[one][resource]! < count {
                return false
            }
        }
        
        for (resource, count) in resources {
            hands[one][resource] = hands[one][resource]! - count
            hands[two][resource] = hands[two][resource]! + count
        }
        
        return true
    }
    
    mutating func build(_ building: Building, for player: UInt, at tile: UInt, on side: UInt) -> Bool {
        let currentBuilding = tiles[tile].buildings[side]
        if building == .city && currentBuilding != nil, currentBuilding! != player { return false }
        
        // TODO: Check if user is allowed to build at location
        
        if !pay(BuildingCost.of(building), from: player) { return false }
        
        // FIXME
        // tiles[tile].buildings[side] = player
        
        return true
    }
    
    private mutating func pay(_ resources: [Resource: UInt], from player: UInt) -> Bool {
        for (resource, count) in resources {
            if hands[player][resource]! < count {
                return false
            }
        }
        
        for (resource, count) in resources {
            hands[player][resource] = hands[player][resource]! - count
        }
        
        return true
    }
    
    struct BuildingCost {
        static let road: [Resource: UInt] = [
            .lumber: 1,
            .brick: 1,
        ]
        
        static let settlement: [Resource: UInt] = [
            .lumber: 1,
            .brick: 1,
            .grain: 1,
            .wool: 1,
        ]
        
        static let city: [Resource: UInt] = [
            .grain: 2,
            .ore: 3,
        ]
        
        static let development: [Resource: UInt] = [
            .grain: 1,
            .wool: 1,
            .ore: 1,
        ]
        
        static func of(_ building: Building) -> [Resource: UInt] {
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
