//
//  Player.swift
//  Minigames
//
//  Created by Tomer Israeli on 31/05/2021.
//

import Foundation

struct Player {
    var nickname: String
    private var resources: [Resource]
    
    init(_ nickname: String, _ resources: [Resource]) {
        self.nickname = nickname
        self.resources = resources
    }
}
