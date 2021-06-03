import Foundation

/// a protocol which difines the way the UI should intercat with the model.
protocol SettlersGame {
    
    /*
     notice that some members may change throughout the game. therefore, they are the type of Publisher.
     while implemnting the game you shuould decalre a @Published member and sink them or sink to a system Publisher such as the one in a URLSesssion
     */
    
    var tilesPublisher:                 Published<[Tile]>.Publisher             { get }
    var playersPublisher:               Published<[Player]>.Publisher           { get }
    var currentPlayerIDPublisher:       Published<UUID?>.Publisher              { get }
    var gameStatePublisher:             Published<SettlersGameState>.Publisher  { get }
    
    var pointsToWin:        Int     { get } // how much points are nedded to win the game
    var localPlayerID:      UUID    { get }

    /// Join or create a new game
    /// - Parameter player: the player to join the game as
    init(joinAs player: Player)
    
    // MARK: Purchase
    
    /// Make sure a purchase is valid. may be used by the UI before the user is making the purchase
    /// - Parameters:
    ///   - building: which kind of building to purchase
    ///   - position: where to position this building
    /// - throws: an Error of type `SettlersGameError` if the given position is not valid
    /// - returns: true if the purchase is valid, false otherwise
    func validatePurchase(of building: Building, at position: BuildingPosition) throws -> Bool
    
    /// make a purchase
    /// - Parameters:
    ///   - building: which kind of building to purchase
    ///   - position: where to position this building
    /// - throws: an Error of type `SettlersGameError` if the given position  or the purchase is not valid
    func purchase(of building: Building, at position: BuildingPosition) throws
    
    //MARK: trades
    //todo: find good names and write docs
    func validateTrade(convert: [Resource], to: [Resource]) -> Bool
    
    func tradeWithBank(convert: [Resource], to: [Resource]) throws
        
    func askForTrade(convert: [Resource], to: [Resource]) throws
    
    /// place a knight on a tile
    /// - Parameters:
    ///   - row: the row of the tile
    ///   - column: the column of the tile
    /// - throws: SettlersGameError if the user cant place a knight
    func placeKnight(row: Int, column: Int) throws
    
    //MARK: player actions:
    
    /// log out of the game
    /// this function should make sure all user buildings, cards and resources are taken care of
    func exitGame()
    
    /// roll the dice and update the game state
    /// - returns:  the result of both dice as well as the sum
    func rollDice() -> (sum: Int, dice1: Int, dice2: Int)
    
    /// notify the game that the player has finished his turn
    /// - throws: an Error of type `SettlersGameError` if the turn cant be ended (for example, the dice hadnt been rooled yet)
    func finishTurn() throws
}
