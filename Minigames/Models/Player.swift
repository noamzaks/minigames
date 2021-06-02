//
//  Player.swift
//  Minigames
//
//  Created by Tomer Israeli on 31/05/2021.
//

import Foundation

class Player: ObservableObject, Identifiable {
    var id: UUID = UUID() //may be better to use the database for this one
    var nickname: String
    @Published var resources: [Resource]
    
    init(_ nickname: String, _ resources: [Resource]) {
        self.nickname = nickname
        self.resources = resources
    }
}

extension Player:Equatable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        lhs.id == rhs.id
    }
}
