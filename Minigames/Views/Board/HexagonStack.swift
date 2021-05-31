//
//  HexagonStack.swift
//  Minigames
//
//  Created by Tomer Israeli on 30/05/2021.
//

import SwiftUI


/// A view to organize views in hoenycomb layout
struct HexagonStack<Item>: View where Item: View {
    
    /// the amount of items to fit in the middle row
    var maxColumns: Int
    /// the amount of items to fit in the top and bottom rows of the stack
    var minColumns: Int
    /// the space between hexagons sides in the stack
    var spacing: CGFloat = 10
    
    private var viewForIndex: (Int) -> Item
    
    init(_ maxColumns: Int = 5, _ minColumns: Int = 3,@ViewBuilder viewForIndex: @escaping (Int) -> Item) {
        self.maxColumns = maxColumns
        self.minColumns = minColumns
        self.viewForIndex = viewForIndex
    }
    
    var body: some View {
            GeometryReader{ geometry in
                body(for: geometry.size)
                    .position(x: geometry.frame(in: .local).midX,
                              y: geometry.frame(in: .local).midY)
            }
    }
    
    private func body(for size: CGSize) -> some View{
        let itemSize = itemSize(for: size)
        let horizontalOffset = horizontalOffset(for: itemSize)
        let verticalOffset = verticalOffset(for: itemSize)
        
        var numberOfColumnsByRow = Array((minColumns...maxColumns))
        numberOfColumnsByRow.append(contentsOf: Array(minColumns...maxColumns-1).reversed())
            
        return
            VStack(alignment: .center, spacing: verticalOffset){
                ForEach(Array(numberOfColumnsByRow.enumerated()), id: \.offset){ row, numberOfColumns in
                    HStack(spacing: horizontalOffset) {
                        ForEach(0..<numberOfColumns){ column in
                            viewForIndex(index(at: column, row: row))
                                .frame(width: itemSize, height: itemSize)
                                .clipShape(Hexagon())
                                .overlay(Hexagon().stroke())
                        }
                    }
                }
            }
    }
    
    /// find the max possible item size to fit all items in the avilabile space
    /// - Parameter size: the avilabile space
    /// - Returns: the size of the items as `CGFloat`
    private func itemSize(for size: CGSize) -> CGFloat{
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
        return min(maxHeight, maxWidth)
    }
    
    
    private func horizontalOffset(for itemSize: CGFloat) -> CGFloat{
        let offset = itemSize * (1 - cos(CGFloat.pi / 6))
        return spacing - offset
    }
    
    private func verticalOffset(for itemSize: CGFloat) -> CGFloat{
        let offset = -0.25 * itemSize
        return spacing * sqrt(0.75) + offset
    }
    
    private func index(at column: Int, row: Int) -> Int{
        let middleRow = maxColumns - minColumns

        if middleRow >= row {
            return ((2 * minColumns + row ) * (row) / 2) + column
        } else {
            return (minColumns + maxColumns) * (maxColumns - minColumns + 1)/2 + ((2 * maxColumns - (row - middleRow) ) * (row - middleRow)/2) + column
        }
    }
    
}

#if DEBUG
struct HexagonStack_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            HexagonStack{ index in
                Text("\(index)")
            }
        }
            .previewLayout(.fixed(width: 500, height: 500))
    }
}
#endif

