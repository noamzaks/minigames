//
//  Player.swift
//  Minigames
//
//  Created by Tomer Israeli on 31/05/2021.
//

import Foundation
import UIKit.UIColor

class Player: ObservableObject, Identifiable {
    var id: UUID = UUID() //may be better to use the database for this one
    var nickname: String
    var image: URL?
    var color: UIColor
    @Published var resources: [Resource]
    
    init(_ nickname: String, _ color: UIColor = .red, _ imageURL: URL? = nil) {
        self.nickname = nickname
        self.resources = []
        self.image = imageURL
        self.color = color
    }
}

extension Player: Equatable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        lhs.id == rhs.id
    }
}

extension Player: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(nickname)
    }
}
