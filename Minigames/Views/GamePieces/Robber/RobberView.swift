//
//  KnightView.swift
//  Minigames
//
//  Created by Tomer Israeli on 18/06/2021.
//

import SwiftUI

struct RobberView<Game: SettlersGame>: View {
    
    @EnvironmentObject var boardVM: BoardViewModel<Game>
        
    var body: some View {
        Text("🥷")
            .font(.system(size: boardVM.itemSize * self.knightRelativeSize))
    }
    
    private var knightRelativeSize: CGFloat = 0.23

}

struct KnightView_Previews: PreviewProvider {
    static var previews: some View {
        RobberView<LocalSettlersGame>()
            .environmentObject(BoardViewModel(gameVM: mocGameViewModel))
    }
}
