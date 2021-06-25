//
//  DragablesBoxView.swift
//  Minigames
//
//  Created by Tomer Israeli on 24/06/2021.
//

import SwiftUI

struct DraggablesBoxView<Game: SettlersGame>: View {
    
    @ObservedObject var board: BoardViewModel<Game>
    
    var body: some View {
        HStack {
            
            DraggableSettlementView(boardVM: self.board)
            
            DraggableSettlementView(boardVM: self.board) //should be city
            
            DraggbleRoadView(boardVM: self.board)
            
        }
    }
}

struct DragablesBoxView_Previews: PreviewProvider {
    static var previews: some View {
        DraggablesBoxView(board: BoardViewModel(gameVM: mocGameViewModel))
    }
}
