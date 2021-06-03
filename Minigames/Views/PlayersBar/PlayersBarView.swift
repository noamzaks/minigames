//
//  PlayersBarView.swift
//  Minigames
//
//  Created by Tomer Israeli on 03/06/2021.
//

import SwiftUI

struct PlayersBarView<Game: SettlersGame>: View {
    
    @ObservedObject var gameVM: SettlersGameViewModel<Game>
    
    var body: some View {
        HStack {
            ForEach(gameVM.players) { player in
                PlayerView(player.id, currentPlayerID: gameVM.currentPlayerID)
                    .environmentObject(player)
            }
        }
    }
}

struct PlayersBarView_Previews: PreviewProvider {
    static var previews: some View {
        @ObservedObject var vm = mocGameViewModel
        return PlayersBarView(gameVM: vm)
    }
}
