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
    
    private func background(for tile: Tile) -> AnyView{
        switch tile.terrain {
        case .desert:
            return AnyView(Color.yellow)
        case .forest:
            return AnyView(Color.green)
        case .fields:
            return AnyView(Color.green.opacity(0.6))
        case .hills:
            return AnyView(Color.purple)
        case .mountains:
            return AnyView(Color.gray)
        case .pasture:
            return AnyView(Color.red)
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
                                .frame(width: size.width * TileView.dotsRelativeSize,
                                       height: size.height * TileView.dotsRelativeSize)
                        }
                    }
                }
                .padding()
                .frame(width: size.height * TileView.tagRelativeSize,
                       height: size.width * TileView.tagRelativeSize)
                .background(Color(UIColor.systemBackground))
                .clipShape(Circle())
            }
            
            if tile.knightIsIn {
                Text("🥷")
                    .font(.system(size: size.width * TileView.knightRelativeSize))
                    .offset(knightOffset(for: size))
            }
        }
        
        
    }
    
    func knightOffset(for size: CGSize) ->  CGSize {
        
        guard tile.diceValue != nil else {
            return .zero
        }
        
        let y = size.height * TileView.tagRelativeSize * 0.5
        let x = size.width * TileView.tagRelativeSize * 0.5
        return CGSize(width: x, height: y)
    }
    
    private static var tagRelativeSize: CGFloat = 0.33
    private static var textRelativeSize: CGFloat = 0.15
    private static var knightRelativeSize: CGFloat = 0.23
    private static var dotsRelativeSize: CGFloat = 0.017
    
    
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TileView()
            
            TileView()
                .preferredColorScheme(.dark)
            
        }
        .environmentObject(Tile(terrain: .mountains, dice: (3,3), row: 2, column: 2, knightIsIn: true))
        .previewLayout(.fixed(width: 300, height: 300))
        .clipShape(Hexagon())
    }
}
