//
//  TileView.swift
//  Minigames
//
//  Created by Tomer Israeli on 02/06/2021.
//

import SwiftUI

struct TileView: View {
    
    @EnvironmentObject var tile: Tile
    
    var body: some View {
        GeometryReader { geometry in
            background(for: tile)
                .overlay(tag(for: tile, in: geometry.size))
        }
    }
    
    private func background(for tile: Tile) -> some View{
        Group {
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
    }
    
    private func icon(for tile: Tile, in size: CGSize) -> some View {
        Group {
            if let icon = tile.terrain.resource?.icon {
                Text(icon)
                    .font(.system(size: size.width * TileView.iconRelativeSize))
            }
        }
    }
    
    private func tag(for tile: Tile, in size: CGSize) -> some View {
        ZStack() {
            if let diceValue = tile.diceValue {
                VStack(spacing: 0) {
                    
                    Text("\(diceValue.value)")
                        .font(.system(size: size.width * TileView.textRelativeSize))
                    
                    HStack(spacing: size.width * TileView.dotsRelativeSize) {
                        ForEach(0..<diceValue.probability) { _ in
                            Circle()
                                .frame(width: dotSize(in: size),
                                       height: dotSize(in: size))
                        }
                    }
                }
                .padding()
                .frame(width: size.height * TileView.tagRelativeSize,
                       height: size.width * TileView.tagRelativeSize)
                .background(Color(UIColor.systemBackground))
                .clipShape(Circle())
                
            }
            
            icon(for: tile, in: size)
                .offset(iconOffset(for: size))
            
            if tile.knightIsIn {
                Text("🥷")
                    .font(.system(size: size.width * TileView.knightRelativeSize))
                    .offset(knightOffset(for: size))
            }
            
            
            
        }
//        .overlay(Text("\(tile.diceValue.debugDescription)").font(.system(size: 10)).foregroundColor(.red))
        
        
    }
    
    func knightOffset(for size: CGSize) -> CGSize {
        
        guard tile.diceValue != nil else {
            return .zero
        }
        
        let y = size.height * TileView.tagRelativeSize * 0.5
        let x = size.width * TileView.tagRelativeSize * 0.5
        return CGSize(width: x, height: y)
    }
    
    func iconOffset(for size: CGSize) -> CGSize {
        let y = size.height * TileView.tagRelativeSize * -0.5
        let x = size.width * TileView.tagRelativeSize * -0.5
        return CGSize(width: x, height: y)
    }
    
    func dotSize(in size: CGSize) -> CGFloat {
        min(size.width * TileView.dotsRelativeSize,
            size.height * TileView.dotsRelativeSize)
    }
    
    private static var tagRelativeSize: CGFloat = 0.33
    private static var textRelativeSize: CGFloat = 0.15
    private static var knightRelativeSize: CGFloat = 0.23
    private static var iconRelativeSize: CGFloat = 0.18
    private static var dotsRelativeSize: CGFloat = 0.015
    
    
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TileView()
            
            TileView()
                .preferredColorScheme(.dark)
            
        }
        .environmentObject(Tile(terrain: .mountains, dice: (12,1), row: 2, column: 2, knightIsIn: false))
        .previewLayout(.fixed(width: 150, height: 150))
        .clipShape(Hexagon())
    }
}
