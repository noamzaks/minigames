//
//  SettlersGameViewModel.swift
//  Minigames
//
//  Created by Tomer Israeli on 02/06/2021.
//

import Foundation
import Combine

class SettlersGameViewModel<Game>: ObservableObject where Game: SettlersGame {
    
    private var game: Game
    private var cancellables: Array<AnyCancellable> = .init()
    
    @Published var localPlayerIsPlaying: Bool = false
    @Published var currentPlayerID: UUID? = nil
    
    @Published var tiles: [Tile] = []
    @Published var players: [Player] = []
    @Published var gameState: SettlersGameState = SettlersGameState.waitingForPlayers(connectedPlayers: [])
    
    
    init(_ player: Player) {
        self.game = Game(joinAs: player)
        
        game.currentPlayerIDPublisher
            .map{ $0 == self.game.localPlayerID }
            .assign(to: \.localPlayerIsPlaying, on: self)
            .store(in: &cancellables)
        
        game.currentPlayerIDPublisher
            .assign(to: \.currentPlayerID, on: self)
            .store(in: &cancellables)

        
        game.tilesPublisher
            .assign(to: \.tiles, on: self)
            .store(in: &cancellables)
        
        game.playersPublisher
            .assign(to: \.players, on: self)
            .store(in: &cancellables)
        
        game.gameStatePublisher
            .sink { state in
                
            }
            .store(in: &cancellables)
    }
    
    var localPlayer: Player{
        if let localPlayer = players.first(where: { $0.id == game.localPlayerID }) {
            return localPlayer
        } else {
            fatalError("couldnt find local player in players array")
        }
    }
    
    //MARK: Intents
    public func rollDice(){
        let _ = game.rollDice()
    }
}

#if DEBUG

let mocGameViewModel = SettlersGameViewModel<LocalSettlersGame>(Player("tomer", URL(string: "https://www.humanesociety.org/sites/default/files/styles/1240x698/public/2018/07/bird-eagle-flight.jpg?h=5bbcce53&itok=wIQc9zhg")))

#endif
