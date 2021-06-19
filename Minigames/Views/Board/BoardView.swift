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
        HexagonStack(boardVM) { row, column, size in
            tileView(row: row, column: column, size: size)
        }
        .buildingsOverlay(boardVM){ building in
            buildingView(for: building)
        }
        .padding()
    }
    
    @ViewBuilder
    private func buildingView(for building: Building) -> some View {
        switch building {
        case .city(_, let owner):
            CityView<Game>(for: owner)
        case .settelment(_, let owner):
            SettlementView<Game>(for: owner)
        case .road(_, let owner):
            RoadView<Game>(for: owner)
        }
    }
    
    @ViewBuilder
    private func tileView(row: Int, column: Int, size: CGFloat) -> some View {
        if let tile = boardVM.tileAt(row, column){
            TileView<Game>(tile)
                .environmentObject(boardVM)
                .frame(width: size, height: size)
                .clipShape(Hexagon())
                .shadow(color: tileShadow(for: tile), radius: 20)
            
        } else {
            Image(systemName: "exclamationmark.triangle")
            
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
        let vm = BoardViewModel(gameVM: mocGameViewModel)
        
        return Group {
            BoardView(boardVM: vm)
                .previewLayout(.fixed(width: 1000, height: 1000))
            
            BoardView(boardVM: vm)
                .preferredColorScheme(.dark)
                .previewLayout(.fixed(width: 1000, height: 1000))
        }
    }
}
