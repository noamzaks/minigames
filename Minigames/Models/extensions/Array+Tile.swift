//
//  Array+Tile.swift
//  Minigames
//
//  Created by Tomer Israeli on 31/05/2021.
//

import Foundation

extension Array where Element == Tile {
    
    func get(row: Int, column: Int) -> Tile?{
        self.first { $0.row == row && $0.column == column }
    }
    
}
