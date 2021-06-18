//
//  DraggableKnightView.swift
//  Minigames
//
//  Created by Tomer Israeli on 18/06/2021.
//

import SwiftUI

struct DraggableRobberView<Game: SettlersGame>: View {
    
    @ObservedObject var boardVM: BoardViewModel<Game>
    
    init(boardVM: BoardViewModel<Game>) {
        self.boardVM = boardVM
        
    }
    
    var body: some View {
        RobberView<Game>()
            .draggableGamePiece($boardVM.knightLocation) {
                
            }
            .environmentObject(boardVM)
    }
    
    
}
struct DraggableKnightView_Previews: PreviewProvider {
    static var previews: some View {
        DraggableRobberView(boardVM: BoardViewModel(gameVM: mocGameViewModel))
    }
}
