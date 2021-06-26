//
//  CityView.swift
//  Minigames
//
//  Created by Tomer Israeli on 19/06/2021.
//

import SwiftUI

struct CityView: View {
    var owner: Player
    @EnvironmentObject var boardVM: BoardViewModel
    
    init(for owner: Player) {
        self.owner = owner
    }
    
    var body: some View {
        SettlementView(for: owner)
            .overlay(
                Text("×2")
                    .font(boardVM.textFont)
            )
    }
}
