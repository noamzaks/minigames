//
//  HexagonStackViewModel.swift
//  Minigames
//
//  Created by Tomer Israeli on 13/06/2021.
//

import SwiftUI

class HexagonStackViewModel: ObservableObject {
        
    var dimensions: (frame: CGRect, spacing: CGFloat, maxColumns: Int, minColumn: Int)? {
        didSet {
            guard let d = self.dimensions, d.frame.size != oldValue?.frame.size else { return }
            
            self.updateDimensions(in: d.frame,
                                  spacing: d.spacing,
                                  maxColumns: d.maxColumns,
                                  minColumns: d.minColumn)
        }
    }
    
    private(set) var itemSize: CGFloat = 0
    private(set) var horizontalOffset: CGFloat = 0
    private(set) var verticalOffset: CGFloat = 0
    
    /// find the max possible item size to fit all items in the avilabile space
    /// - Parameters:
    ///   - geometry: the GeometryProxy of the stack
    ///   - spacing: the distance between tiles
    ///   - maxColumns: the max amount of columns in a row
    ///   - minColumns: the min amount of columns in a row
    internal func updateDimensions(in frame: CGRect, spacing: CGFloat, maxColumns: Int, minColumns: Int) {
        let size = CGSize(width: frame.width, height: frame.height)
        
        let cos_30 = cos(CGFloat.pi / 6)
        
        //  the avilabile space to draw items is the view size minus the spacing between items: spacing*(n-1).
        let RWidthCounter: CGFloat = size.width - spacing * CGFloat(maxColumns-1)
        
        //  in this space we want to fit all the items and two gaps. the gaps are result of the fact that hexagons does not reach the side of their blocking square. each gap,at the begining and at the end of the line, is equal to R(1 - cos(30) where R is the radius of the hexagon blocking circle or half the square side. therefore the amount of Rs we want to fit is n * (2R * cos30) + 2 * (1-cos30) * R
        let RWidthDenominator: CGFloat = 2 * cos_30 * CGFloat(maxColumns) + 2 * (1 - cos_30)
        
        //  the max width is 2*R
        let maxWidth: CGFloat = 2 * RWidthCounter /  RWidthDenominator
        
        //  the avilabile height to draw items is the view height minus the the spacing between hexagons which we can easily find using geometry to: spacing * sqrt(0.75) * (n-1).
        let heightCounter: CGFloat = size.height - spacing * sqrt(0.75) * CGFloat(maxColumns - 1)
        
        //  to make our life easier we will divide is each hexagon into 3 parts, a rectangle(with the height of R) and two triangles(with hight of R/2). therefore the amount of items we are looking to fit in that space is n rectangles and n+1 triangles or n*R + R*(n+1) / 2
        let heightDenominator: CGFloat = 1.5 * CGFloat(maxColumns) + 0.5
        
        //  the max height is 2*R
        let maxHeight: CGFloat = 2 * heightCounter / heightDenominator
        
        //  in order to fit the items nicely, the size of each item is the min between two values, the max possible width and max possible height.
        self.itemSize = min(maxHeight, maxWidth)
        
        self.horizontalOffset = spacing - (itemSize * (1 - cos(CGFloat.pi / 6)))
        
        self.verticalOffset = spacing * sqrt(0.75) + (-0.25 * itemSize)
        
        self.objectWillChange.send()
        
    }
 
    var radius: Float {
        Float(self.itemSize + (self.dimensions?.spacing ?? 0))/2
    }
    
}
