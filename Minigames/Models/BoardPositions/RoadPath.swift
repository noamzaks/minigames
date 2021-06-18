//
//  Path.swift
//  Minigames
//
//  Created by Tomer Israeli on 04/06/2021.
//

import Foundation
import simd

class RoadPath: BoardPosition {    
    private var intersections:(Intersection, Intersection)
    
    init?(from intersection1: Intersection, to intersection2: Intersection) {
        // if the distance between the intersections is no 1 there isnt a single path between them
        guard length(intersection1.boardPosition()-intersection2.boardPosition()) == 1 else { return nil }
        intersections = (intersection1, intersection2)
    }
    
    var angleRelativeToX: Float {
        let vetcor = intersections.0.boardPosition() - intersections.1.boardPosition()
        let xAxes: SIMD2<Float> = .init(1, 0)
        return acos(simd_dot(vetcor, xAxes) / length(vetcor))
    }
}

extension RoadPath: Hashable, Equatable {
    
    // find the path center relative to the middle tile of the board
    func boardPosition() -> SIMD2<Float>{
        (intersections.0.boardPosition() + intersections.1.boardPosition()) / 2
    }
    
    static func == (lhs: RoadPath, rhs: RoadPath) -> Bool {
        lhs.boardPosition() == rhs.boardPosition()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.boardPosition())
    }
}
