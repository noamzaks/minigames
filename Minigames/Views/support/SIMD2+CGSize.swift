//
//  SIMD2+CGPoint.swift
//  Minigames
//
//  Created by Tomer Israeli on 18/06/2021.
//

import CoreGraphics

extension SIMD2 where Scalar == Float {
    var asCGSize: CGSize {
        .init(width: Double(self.x), height: Double(self.y))
    }
    
    public mutating func reverseY() {
        self.y *= -1
    }
}
