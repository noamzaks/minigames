//
//  KnightView.swift
//  Minigames
//
//  Created by Tomer Israeli on 18/06/2021.
//

import SwiftUI

struct RobberView: View {
    
    @EnvironmentObject var boardVM: BoardViewModel
        
    var body: some View {
        Text("🥷")
            .font(boardVM.bigIconFont)
    }
    
    private var knightRelativeSize: CGFloat = 0.23

}

struct KnightView_Previews: PreviewProvider {
    static var previews: some View {
        RobberView()
            .environmentObject(BoardViewModel(gameVM: mocGameViewModel))
    }
}
