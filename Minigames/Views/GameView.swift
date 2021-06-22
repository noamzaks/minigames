//
//  GameView.swift
//  Minigames
//
//  Created by Tomer Israeli on 02/06/2021.
//

import SwiftUI

struct GameView<Game: SettlersGame>: View {
    
    @ObservedObject var gameVM: SettlersGameViewModel<Game>
    @ObservedObject var boardVM: BoardViewModel<Game>
    
    @State private var showSecodary: Bool = false
    
    init(_ gameVM: SettlersGameViewModel<Game>) {
        self.boardVM = BoardViewModel(gameVM: gameVM)
        self.gameVM = gameVM
    }
    
    var body: some View {
        mainView
            .edgesIgnoringSafeArea(.all)
        
    }
    
    private var mainView: some View {
        ZStack(alignment: .bottom) {

            VStack {
                
                HStack {
                
                PlayerView(currentPlayerID: gameVM.currentPlayerID)
                    .environmentObject(gameVM.localPlayer)
                    
                    Spacer()
                }
                
                BoardView(board: boardVM)
                
                
                HStack(alignment: .bottom) {
                    
                    
                    ResourceBarView(player: gameVM.localPlayer)
                    
                    DraggableRobberView(boardVM: self.boardVM)
                    
                    DraggbleRoadView(boardVM: self.boardVM)
                    
                    DraggableSettlementView(boardVM: self.boardVM)
                }
                
                
            }
            
//            Circle()
//                .frame(width: 30, height: 30)
//                .position(boardVM.knightPosition)
            
            
        }
        .padding()
        
    }
    
    private var tradesView: some View {
        Text("secondary")
            .edgesIgnoringSafeArea(.all)
            .background(Color.red)
    }
    
    
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GameView(mocGameViewModel)
                .preferredColorScheme(.light)
        }
    }
}
