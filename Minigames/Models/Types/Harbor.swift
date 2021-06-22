//
//  Harbor.swift
//  Minigames
//
//  Created by Tomer Israeli on 21/06/2021.
//

import Foundation

struct Harbor: BoardPosition {
    
    var intersection: Intersection
    var get: [Resource]
    var give: [Resource]
    
    init(at intersection: Intersection, get: [Resource], give: [Resource]) {
        self.intersection = intersection
        self.get = get
        self.give = give
    }
    
    func boardPosition() -> SIMD2<Float> { intersection.boardPosition() }
    
}
