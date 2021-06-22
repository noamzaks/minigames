//
//  BoardView.swift
//  Minigames
//
//  Created by Tomer Israeli on 02/06/2021.
//

import SwiftUI

struct BoardView<Game: SettlersGame>: View {
    
    @ObservedObject var board: BoardViewModel<Game>
    
    var body: some View {
        HexagonStack(board) { row, column, size in
            tileView(row: row, column: column, size: size)
        }
        .buildingsOverlay(board)
//        .zoomable()
    }
    
    
    @ViewBuilder
    private func tileView(row: Int, column: Int, size: CGFloat) -> some View {
        if let tile = board.tileAt(row, column){
            TileView<Game>(tile)
                .environmentObject(board)
                .frame(width: size, height: size)
                .clipShape(Hexagon())
                .shadow(color: tileShadow(for: tile), radius: board.shadowRadius)
            
        } else {
            Image(systemName: "exclamationmark.triangle")
        }
    }
    
    private func tileShadow(for tile: Tile) -> Color {
        if tile == board.knightHoveringTile {
            return tile.knightIsIn ? .red : .green
        } else {
            return .clear
        }
    }
    
}

struct BoardView_Previews: PreviewProvider {
    
    static var previews: some View {
        let vm = BoardViewModel(gameVM: mocGameViewModel)
        
        return Group {
            BoardView(board: vm)
                .previewLayout(.fixed(width: 1000, height: 1000))
            
            BoardView(board: vm)
                .preferredColorScheme(.dark)
                .previewLayout(.fixed(width: 1000, height: 1000))
        }
        .padding()

    }
}
