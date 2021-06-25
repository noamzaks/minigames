//
//  ActionBarView.swift
//  Minigames
//
//  Created by Tomer Israeli on 09/06/2021.
//

import SwiftUI

struct ActionBarView<Game: SettlersGame>: View {
    
    @ObservedObject var boardVM: BoardViewModel<Game>
    
    @State private var selection: Int = 0
    
    init(boardVM: BoardViewModel<Game>) {
        self.boardVM = boardVM
    }
    
    var body: some View {
        HStack(alignment: .bottom) {
            
            TabView(selection: $selection) {
                GameStateView<Game>(gameState: $boardVM.gameVM.gameState)
                    .tag(0)
                
                ResourcesBoxView(player: self.boardVM.gameVM.localPlayer)
                    .tag(1)
                
                DraggablesBoxView(board: boardVM)
                    .tag(2)
                
//                PlayersBarView(gameVM: boardVM.gameVM)
//                    .tag(3)
                
                
            }
            
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        
    }
    
    private var actionButton: some View {
        Button("rool dice") {
            
        }
        
        //                    DraggableRobberView(boardVM: self.boardVM)
        
    }
    
    
    
}

struct ActionBarView_Previews: PreviewProvider {
    static var previews: some View {
        ActionBarView(boardVM: BoardViewModel(gameVM: mocGameViewModel))
    }
}
