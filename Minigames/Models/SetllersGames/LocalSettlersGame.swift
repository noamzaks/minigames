//
//  File.swift
//  Minigames
//
//  Created by Tomer Israeli on 02/06/2021.
//

import Foundation

class LocalSettlersGame: SettlersGame {
    
    @Published var trades: [Trade] = []
    var tradesPublisher: Published<[Trade]>.Publisher { $trades }
    
    @Published var buildings: [Building] = []
    var buildingsPublisher: Published<[Building]>.Publisher { $buildings }
    
    @Published var harbors: [Harbor] = []
    var harborsPublisher: Published<[Harbor]>.Publisher { $harbors }
    
    @Published var tiles: [Tile] = []
    var tilesPublisher: Published<[Tile]>.Publisher { $tiles }
    
    @Published var players: [Player] = []
    var playersPublisher: Published<[Player]>.Publisher { $players }
    
    @Published var currentPlayerID: UUID? = nil
    var currentPlayerIDPublisher: Published<UUID?>.Publisher { $currentPlayerID }
    
    @Published var gameState: SettlersGameState = SettlersGameState.waitingForPlayers(connectedPlayers: [])
    var gameStatePublisher: Published<SettlersGameState>.Publisher { $gameState }
    
    var localPlayerID: UUID

    var pointsToWin: Int = 10

    required init(joinAs player: Player) {
        player.resources = LocalSettlersGame.playerInitialResources
        localPlayerID = player.id
        players.append(player)
        
        currentPlayerID = player.id
        
        players.append(Player("moc player 1"))
        players.append(Player("moc player 2"))
        players.append(Player("moc player 3"))
        
        //create a borad
        var positions = LocalSettlersGame.boardPosition.shuffled()
        let dice = LocalSettlersGame.boardDiceValues.shuffled()
        var terrains = LocalSettlersGame.boardTerrains.shuffled().filter { $0 != .desert}
        
        for diceValue in dice {
            let pos = positions.popLast()!
            tiles.append(Tile(terrain: terrains.popLast()!, dice: diceValue, row: pos.row, column: pos.column, knightIsIn: false))
        }

        tiles.append(Tile(terrain: .desert, dice: nil, row: positions.first!.row, column: positions.first!.column, knightIsIn: true))

        tiles[0].knightIsIn = true
        
        //moc buildings:
        self.buildings.append(.city(intersection: Intersection(on: tiles.get(row: 1, column: 1)!, at: .topRight), owner: player))
        self.buildings.append(.settelment(intersection: Intersection(on: tiles.get(row: 1, column: 1)!, at: .top), owner: player))
        self.buildings.append(.road(path: RoadPath(on: tiles.get(row: 1, column: 1)!, at: .topRight), owner: player))
        self.buildings.append(.road(path: RoadPath(on: tiles.get(row: 1, column: 1)!, at: .right), owner: player))
        self.buildings.append(.road(path: RoadPath(on: tiles.get(row: 2, column: 2)!, at: .topLeft), owner: player))
        self.buildings.append(.road(path: RoadPath(on: tiles.get(row: 2, column: 2)!, at: .left), owner: player))
        self.buildings.append(.road(path: RoadPath(on: tiles.get(row: 2, column: 2)!, at: .topRight), owner: player))
        self.buildings.append(.settelment(intersection: Intersection(on: tiles.get(row: 3, column: 1)!, at: .top), owner: player))
        
        self.buildings.append(.settelment(intersection: Intersection(on: tiles.get(row: 4, column: 2)!, at: .top), owner: players[1]))
        self.buildings.append(.road(path: RoadPath(on: tiles.get(row: 3, column: 2)!, at: .right), owner: players[1]))
        self.buildings.append(.city(intersection: Intersection(on: tiles.get(row: 2, column: 4)!, at: .top), owner: players[1]))
        self.buildings.append(.road(path: RoadPath(on: tiles.get(row: 2, column: 4)!, at: .bottomLeft), owner: players[1]))
        
        self.harbors.append(Harbor(on:RoadPath(on: tiles.get(row: 0, column: 0)!, at: .left), get: [.brick], give: [.lumber]))
        self.harbors.append(Harbor(on:RoadPath(on: tiles.get(row: 4, column: 2)!, at: .right), get: [.lumber], give: [.lumber]))
        self.harbors.append(Harbor(on:RoadPath(on: tiles.get(row: 4, column: 0)!, at: .bottomLeft), get: [.brick], give: [.wool]))
        self.harbors.append(Harbor(on:RoadPath(on: tiles.get(row: 0, column: 2)!, at: .topRight), get: [.brick], give: [.lumber]))
        
    }
    
    func validatePurchase(of building: Building) throws -> Bool {
        return true
    }
    
    func purchase(of building: Building) throws {
        
    }
    
    func tradeWithBank(give: [Resource], get: [Resource]) throws {
        
    }
    
    func askForTrade(give: [Resource], get: [Resource]) throws {
        
    }
    
    func acceptTrade(id tradeID: UUID) throws {
        
    }
    
    func placeKnight(row: Int, column: Int) throws {
        
    }
    
    func exitGame() {
        
    }
    
    func rollDice() -> (sum: Int, dice1: Int, dice2: Int) {
        tiles[0].knightIsIn = true
        return (6, 2, 4)
    }
    
    func finishTurn() throws {
        currentPlayerID = players.randomElement()!.id
    }
    
    
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
