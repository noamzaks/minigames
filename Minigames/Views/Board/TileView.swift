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
        background(for: tile)
            .overlay(tag(for: tile))
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
    
    private func tag(for tile: Tile) -> some View {
        HStack {
            if let diceValue = tile.diceValue {
                VStack(alignment: .center) {
                    Text("\(diceValue.value)")
                        .font(.body)
                    HStack {
                        ForEach(0..<diceValue.probability) { _ in
                            Text("·")
                                .font(.caption)
                        }
                    }
                    .padding(.top, -10)
                }
            }
            
            if tile.knightIsIn {
                Text("🥷")
                    .font(.largeTitle)
            }
        }
        .padding()
        .background(Color.white)
        .clipShape(Capsule(style: .continuous))
    }
    
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        TileView()
            .environmentObject(Tile(terrain: .fields, dice: nil, row: 2, column: 2))
    }
}
