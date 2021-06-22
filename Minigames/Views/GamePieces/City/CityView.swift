//
//  CityView.swift
//  Minigames
//
//  Created by Tomer Israeli on 19/06/2021.
//

import SwiftUI

struct CityView<Game: SettlersGame>: View {
    var owner: Player
    @EnvironmentObject var boardVM: BoardViewModel<Game>
    
    init(for owner: Player) {
        self.owner = owner
    }
    
    var body: some View {
        SettlementView<Game>(for: owner)
            .overlay(
                Text("×2")
                    .font(boardVM.textFont)
            )
    }
}
