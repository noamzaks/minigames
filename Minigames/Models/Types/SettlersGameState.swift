//
//  SettelrsGameState.swift
//  Minigames
//
//  Created by Tomer Israeli on 31/05/2021.
//

import Foundation

enum SettlersGameState {
    case localPlayerFirstTurn
    case localPlayerTurn(placeKnight: Bool, diceRolled: Bool)
    case remotePlayerTurn(player: Player)
    case waitingForPlayers(connectedPlayers: [Player]?)
    case ended(winner: Player?)
}
