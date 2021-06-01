//
//  Building.swift
//  Minigames
//
//  Created by Tomer Israeli on 01/06/2021.
//

import Foundation

enum Building {
    case road
    case settlement
    case city
    
    var requirements: [Resource] {
        return []
    }
}

struct BuildingPosition {
    
}
