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
                        .font(.system(size: size.width * self.textRelativeSize))
                    
                    HStack(spacing: size.width * self.dotsRelativeSize) {
                        ForEach(0..<diceValue.probability) { _ in
                            Circle()
                                .frame(width: dotSize(in: size),
                                       height: dotSize(in: size))
                        }
                    }
                }
                .frame(width: size.height * self.tagRelativeSize,
                       height: size.width * self.tagRelativeSize)
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
                .font(.system(size: size.width * self.iconRelativeSize))
        }
    }
    
    func knightOffset(for size: CGSize) -> CGSize {
        guard tile.diceValue != nil else { return .zero }
        
        let y = size.height * self.tagRelativeSize * 0.5
        let x = size.width * self.tagRelativeSize * -0.5
        return CGSize(width: x, height: y)
    }
    
    func iconOffset(for size: CGSize) -> CGSize {
        let y = size.height * self.tagRelativeSize * 0.5
        let x = size.width * self.tagRelativeSize * 0.5
        return CGSize(width: x, height: y)
    }
    
    func dotSize(in size: CGSize) -> CGFloat {
        min(size.width * self.dotsRelativeSize,
            size.height * self.dotsRelativeSize)
    }
    
    private var tagRelativeSize: CGFloat = 0.33
    private var textRelativeSize: CGFloat = 0.15
    private var knightRelativeSize: CGFloat = 0.23
    private var iconRelativeSize: CGFloat = 0.18
    private var dotsRelativeSize: CGFloat = 0.015
    
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
