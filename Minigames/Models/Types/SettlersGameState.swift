//
//  SettelrsGameState.swift
//  Minigames
//
//  Created by Tomer Israeli on 31/05/2021.
//

import Foundation

enum SettlersGameState {
    case firstTurn(player: Player)
    case playerTurn(placeKnight: Bool, diceRolled: Bool)
    case waitingForPlayers(connectedPlayers: [Player]?)
    case ended(winner: Player?)
}
