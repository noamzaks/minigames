//
//  DraggableSettlementView.swift
//  Minigames
//
//  Created by Tomer Israeli on 21/06/2021.
//

import SwiftUI

struct DraggableSettlementView: View {
    @ObservedObject var boardVM: BoardViewModel
    
    init(boardVM: BoardViewModel) {
        self.boardVM = boardVM
        
        
    }
    
    var body: some View {
        SettlementView(for: boardVM.gameVM.localPlayer)
            .shadow(color: shadowColor, radius: 10)
            .shadow(color: shadowColor, radius: 10)
            .draggableGamePiece($boardVM.draggedSettlementLocation) {
                
            }
            .environmentObject(boardVM)

    }
    
    var shadowColor: Color {
        guard let valid = boardVM.draggedSettlementIsValid else { return .clear }
        return valid ? .green : .red
    }
}
