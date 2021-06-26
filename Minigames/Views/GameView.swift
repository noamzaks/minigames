//
//  GameView.swift
//  Minigames
//
//  Created by Tomer Israeli on 02/06/2021.
//

import SwiftUI

struct GameView: View {
    
    @ObservedObject var gameVM: SettlersGameViewModel
    @ObservedObject var boardVM: BoardViewModel
    
    @State private var showSecodary: Bool = false
    
    init(_ gameVM: SettlersGameViewModel) {
        self.boardVM = BoardViewModel(gameVM: gameVM)
        self.gameVM = gameVM
    }
    
    var body: some View {
        mainView
            .edgesIgnoringSafeArea([.bottom, .horizontal])
        
    }
    
    private var mainView: some View {
        ZStack(alignment: .bottom) {
            
            VStack {
                
//                HStack {
//
//                    PlayerView(currentPlayerID: gameVM.currentPlayerID)
//                        .environmentObject(gameVM.localPlayer)
//
//                    Spacer()
//                }
                
                BoardView(board: boardVM)
                
                Divider()
                
                ActionBarView(boardVM: boardVM)
                    .frame(height: 100)
                    .edgesIgnoringSafeArea([.horizontal])
                    .zIndex(1)
                
            }
            
            
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
                .preferredColorScheme(.dark)
        }
    }
}
