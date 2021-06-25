//
//  Harbor.swift
//  Minigames
//
//  Created by Tomer Israeli on 21/06/2021.
//

import Foundation

struct Harbor: BoardPosition {
    
    var path: RoadPath
    var get: [Resource]
    var give: [Resource]
    
    init(on path: RoadPath, get: [Resource], give: [Resource]) {
        self.path = path
        self.get = get
        self.give = give
    }
    
    func boardPosition() -> SIMD2<Float> { path.boardPosition() }
    
}
