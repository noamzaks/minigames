//
//  TileView.swift
//  Minigames
//
//  Created by Tomer Israeli on 02/06/2021.
//

import SwiftUI

struct TileView<Game: SettlersGame>: View {
    
    @EnvironmentObject var boardVM: BoardViewModel<Game>
    @ObservedObject var tile: Tile
    
    init(_ tile: Tile) {
        self.tile = tile
    }
    
    var body: some View {
        GeometryReader { geometry in
            background(for: tile)
                .overlay(tag(for: tile, in: geometry.size))
        }
    }
    
    @ViewBuilder
    private func background(for tile: Tile) -> some View{
        switch tile.terrain {
        case .desert:
            Color.yellow
        case .forest:
            Color(Terrain.forest.resource!.matchedColor)
        case .fields:
            Color(Terrain.fields.resource!.matchedColor)
        case .hills:
            Color(Terrain.hills.resource!.matchedColor)
        case .mountains:
            Color(Terrain.mountains.resource!.matchedColor)
        case .pasture:
            Color(Terrain.pasture.resource!.matchedColor)
        }
    }
    
    private func tag(for tile: Tile, in size: CGSize) -> some View {
        ZStack() {
            if let diceValue = tile.diceValue {
                VStack(spacing: 0) {
                    
                    Text("\(diceValue.value)")
                        .font(boardVM.diceValueFont)
                    
                    HStack(spacing: self.boardVM.probabilityDotSize) {
                        ForEach(0..<diceValue.probability) { _ in
                            Circle()
                                .frame(width: boardVM.probabilityDotSize,
                                       height: boardVM.probabilityDotSize)
                        }
                    }
                }
                .frame(width: boardVM.tagRadius,
                       height:boardVM.tagRadius)
                .background(Color(UIColor.systemBackground))
                .clipShape(Circle())
                
            }
            
            icon(for: tile, in: size)
                .offset(iconOffset(for: size))
            
            if tile.knightIsIn {
                RobberView<Game>()
                    .offset(knightOffset(for: size))
            }
            
        }
        
    }
    
    @ViewBuilder
    private func icon(for tile: Tile, in size: CGSize) -> some View {
        if let icon = tile.terrain.resource?.icon {
            Text(icon)
                .font(boardVM.bigIconFont)
        }
    }
    
    func knightOffset(for size: CGSize) -> CGSize {
        guard tile.diceValue != nil else { return .zero }
        
        let y = self.boardVM.tagRadius * 0.5
        let x = self.boardVM.tagRadius * -0.5
        return CGSize(width: x, height: y)
    }
    
    func iconOffset(for size: CGSize) -> CGSize {
        let y = self.boardVM.tagRadius * 0.5
        let x = self.boardVM.tagRadius * 0.5
        return CGSize(width: x, height: y)
    }
    
}



struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TileView<LocalSettlersGame>(Tile(terrain: .mountains, dice: (12,1), row: 2, column: 2, knightIsIn: false))
            
            TileView<LocalSettlersGame>(Tile(terrain: .mountains, dice: (12,1), row: 2, column: 2, knightIsIn: false))
                .preferredColorScheme(.dark)
            
        }
        .environmentObject(BoardViewModel(gameVM: mocGameViewModel))
        .previewLayout(.fixed(width: 150, height: 150))
        .clipShape(Hexagon())
    }
}
