//
//  DraggableKnightView.swift
//  Minigames
//
//  Created by Tomer Israeli on 18/06/2021.
//

import SwiftUI

struct DraggableRobberView: View {
    
    @ObservedObject var boardVM: BoardViewModel
    
    init(boardVM: BoardViewModel) {
        self.boardVM = boardVM
        
    }
    
    var body: some View {
        RobberView()
            .draggableGamePiece($boardVM.DraggedRobberLocation) {
                
            }
            .environmentObject(boardVM)
    }
    
    
}
struct DraggableKnightView_Previews: PreviewProvider {
    static var previews: some View {
        DraggableRobberView(boardVM: BoardViewModel(gameVM: mocGameViewModel))
    }
}
