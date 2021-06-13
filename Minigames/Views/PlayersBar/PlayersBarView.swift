//
//  PlayersBarView.swift
//  Minigames
//
//  Created by Tomer Israeli on 03/06/2021.
//

import SwiftUI

struct PlayersBarView<Game: SettlersGame>: View {
    
    @ObservedObject var gameVM: SettlersGameViewModel<Game>
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        switch sizeClass {
        case .compact:
            TabView { playersViews }
                .tabViewStyle(PageTabViewStyle())
                .overlay(Text("\(sizeClass.debugDescription)"))
        default:
            HStack { playersViews }
                .overlay(Text("\(sizeClass.debugDescription)"))

        }
    }
    
    @ViewBuilder
    var playersViews: some View {
        ForEach(gameVM.players) { player in
            PlayerView(currentPlayerID: gameVM.currentPlayerID)
                .environmentObject(player)
        }
    }
    
}

struct PlayersBarView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            PlayersBarView(gameVM: mocGameViewModel)
            PlayersBarView(gameVM: mocGameViewModel)
                .previewDevice("iPhone 12 Pro")
            
            PlayersBarView(gameVM: mocGameViewModel)
                .previewDevice("iPhone 8")
        }
    }
}
