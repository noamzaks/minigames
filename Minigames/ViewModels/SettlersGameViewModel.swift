//
//  SettlersGameViewModel.swift
//  Minigames
//
//  Created by Tomer Israeli on 02/06/2021.
//

import Foundation
import Combine

class SetllersGameViewModel<Game>: ObservableObject where Game: SettlersGame {
    
    private var game: Game
    private var cancellables: Array<AnyCancellable> = .init()
    
    @Published var localPlayerIsPlaying: Bool = false
    @Published var tiles: [Tile] = []
    @Published var players: [Player] = []
    @Published var gameState: SettlersGameState = SettlersGameState.waitingForPlayers(connectedPlayers: [])
    
    
    init(_ nickname: String) {
        self.game = Game(joinAs: nickname)
        
        game.currentPlayerIndexPublisher
            .map{ $0 == self.game.localPlayerIndex }
            .assign(to: \.localPlayerIsPlaying, on: self)
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
        return players[game.localPlayerIndex]
    }
    
    //MARK: Intents
    public func rollDice(){
        let _ = game.rollDice()
    }
    
}
