//
//  HexagonStack.swift
//  Minigames
//
//  Created by Tomer Israeli on 30/05/2021.
//

import SwiftUI
import Combine

/// A view to organize views in hoenycomb layout
struct HexagonStack<Item>: View where Item: View {
    
    /// the amount of items to fit in the middle row
    var maxColumns: Int
    /// the amount of items to fit in the top and bottom rows of the stack
    var minColumns: Int
    /// the space between hexagons sides in the stack
    var spacing: CGFloat = 5
    
    var viewModel: HexagonStackViewModel
    
    /// row, column, itemSize
    private var viewForIndex: (Int, Int, CGFloat) -> Item
    
    init(_ vm: HexagonStackViewModel, _ maxColumns: Int = 5, _ minColumns: Int = 3, @ViewBuilder viewForIndex: @escaping (Int, Int, CGFloat) -> Item) {
        self.maxColumns = maxColumns
        self.minColumns = minColumns
        self.viewForIndex = viewForIndex
        self.viewModel = vm
    }
    
    var body: some View {
        GeometryReader{ geometry in
            body(for: geometry)
                .position(x: geometry.frame(in: .local).midX,
                          y: geometry.frame(in: .local).midY)
        }
//        .coordinateSpace(name: viewModel.coordianteSpace)

    }
    
    private func body(for geometry: GeometryProxy) -> some View{
        viewModel.dimensions = (geometry.frame(in: .global), spacing, maxColumns, minColumns)

        //        let viewModel: (horizontalOffset: CGFloat,
//                        verticalOffset: CGFloat,
//                        itemSize: CGFloat) = (1, 1, 30)
        
        var numberOfColumnsByRow = Array((minColumns...maxColumns))
        numberOfColumnsByRow.append(contentsOf: Array(minColumns...maxColumns-1).reversed())
        
        return
            VStack(alignment: .center, spacing: viewModel.verticalOffset){
                ForEach(Array(numberOfColumnsByRow.enumerated()), id: \.offset){ row, numberOfColumns in
                    HStack(spacing: viewModel.horizontalOffset) {
                        ForEach(0..<numberOfColumns){ column in
                            viewForIndex(row, column, viewModel.itemSize)
                                .frame(width: viewModel.itemSize, height: viewModel.itemSize)
                        }
                    }
                }
            }
    }
    
}



#if DEBUG
struct HexagonStack_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            HexagonStack(HexagonStackViewModel()){ row,column,size  in
                Text("\(row), \(column)")
                    .frame(width: size, height: size)
                    .background(Color.red)
                    .clipShape(Hexagon())
            }
        }
        .previewLayout(.fixed(width: 500, height: 500))
    }
}
#endif

