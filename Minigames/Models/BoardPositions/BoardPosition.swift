//
//  Building.swift
//  Minigames
//
//  Created by Tomer Israeli on 01/06/2021.
//

import Foundation

protocol BoardPosition {
    func boardPosition() -> SIMD2<Float>
        
    var midRow: Int { get }
    var midColumn: Int { get }
}

extension BoardPosition {
    var midRow: Int { return 2 }
    var midColumn: Int { return 2 }
}
