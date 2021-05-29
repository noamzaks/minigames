//
//  Tile.swift
//  Minigames
//
//  Created by Tomer Israeli on 29/05/2021.
//

import Foundation

struct Tile{
    private(set) var terrain: Terrain
    private(set) var value: Int
    private(set) var robberIsIn: Bool

    init(_ terrain: Terrain, _ value: Int, _ robberIsIn: Bool = false) {
        self.terrain = terrain
        self.value = value
        self.robberIsIn = robberIsIn
    }
}
