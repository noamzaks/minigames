//
//  SettlementView.swift
//  Minigames
//
//  Created by Tomer Israeli on 19/06/2021.
//

import SwiftUI

struct SettlementView: View {
    var owner: Player
    @EnvironmentObject var boardVM: BoardViewModel
    
    init(for owner: Player) {
        self.owner = owner
    }
    
    var body: some View {
        Circle()
            .fill(Color(owner.color))
            .frame(width: boardVM.setlementSize,
                   height: boardVM.setlementSize)
    }
}
