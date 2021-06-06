//
//  BoardView.swift
//  Minigames
//
//  Created by Tomer Israeli on 02/06/2021.
//

import SwiftUI

struct BoardView<Game: SettlersGame>: View {
    
    @ObservedObject var gameVM: SettlersGameViewModel<Game>
        
    var body: some View {
        HexagonStack(viewForIndex: tileView)
        .buildingsOverlay(for: gameVM.buildings) { building, radius in
            BuildingView(building: building, tileRadius: radius)
        }
        .padding()
    }
    
    private func tileView(row: Int, column: Int, size: CGFloat) -> some View {
        Group {
            if let tile = TileAt(row, column){
                TileView().environmentObject(tile)
            } else {
                Text("error")
            }
        }
        .frame(width: size, height: size)
        .clipShape(Hexagon())
    }
    
    private func TileAt(_ row: Int, _ column: Int) -> Tile? {
        gameVM.tiles.first { $0.row == row && $0.column == column }
    }
    
    
    
}

struct BoardView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        @ObservedObject var vm = mocGameViewModel
        
        return BoardView(gameVM: vm)
            .previewLayout(.fixed(width: 1000, height: 1000))
    }
}
