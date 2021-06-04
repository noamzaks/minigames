//
//  Path.swift
//  Minigames
//
//  Created by Tomer Israeli on 04/06/2021.
//

import Foundation
import simd

class Path {
    private var intersections:(Intersection, Intersection)
    
    init?(from intersection1: Intersection, to intersection2: Intersection) {
        // if the distance between the intersections is no 1 there isnt a single path between them
        guard length(intersection1.boardPosition()-intersection2.boardPosition()) == 1 else { return nil }
        intersections = (intersection1, intersection2)
    }
}

extension Path: Hashable, Equatable {
    
    // find the path center relative to the middle tile of the board
    func boardPosition() -> SIMD2<Float>{
        (intersections.0.boardPosition() + intersections.1.boardPosition()) / 2
    }
    
    static func == (lhs: Path, rhs: Path) -> Bool {
        lhs.boardPosition() == rhs.boardPosition()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.boardPosition())
    }
}
