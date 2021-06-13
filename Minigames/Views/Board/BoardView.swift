//
//  BoardView.swift
//  Minigames
//
//  Created by Tomer Israeli on 02/06/2021.
//

import SwiftUI

struct BoardView<Game: SettlersGame>: View {
    
    @ObservedObject var boardVM: BoardViewModel<Game>
    
    var body: some View {
        HexagonStack(boardVM, viewForIndex: tileView)
            .buildingsOverlay(for: boardVM.gameVM.buildings) { building, radius in
                BuildingView(building: building, tileRadius: radius)
            }
            .padding()
    }
    
    private func tileView(row: Int, column: Int, size: CGFloat) -> some View {
        GeometryReader { geometry in
            Group {
                if let tile = boardVM.tileAt(row, column){
                    TileView()
                        .environmentObject(tile)
                        .frame(width: size, height: size)
                        .clipShape(Hexagon())
                        .shadow(color: tileShadow(for: tile), radius: 20)
                } else {
                    Text("error")
                }
            }
        }
        
    }
    
    private func tileShadow(for tile: Tile) -> Color {
        if tile == boardVM.knightHoveringTile {
            return tile.knightIsIn ? .red : .green
        } else {
            return .clear
        }
    }
    
}

struct BoardView_Previews: PreviewProvider {
    
    static var previews: some View {
        @ObservedObject var vm = BoardViewModel(gameVM: mocGameViewModel)
        
        return BoardView(boardVM: vm)
            .previewLayout(.fixed(width: 1000, height: 1000))
    }
}
