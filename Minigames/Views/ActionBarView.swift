//
//  ActionBarView.swift
//  Minigames
//
//  Created by Tomer Israeli on 09/06/2021.
//

import SwiftUI

struct ActionBarView<Game: SettlersGame>: View {
    
    @ObservedObject var gameVM: SettlersGameViewModel<Game>
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
//    var diceButton: some View {
////        Button(action: {
////            
////        }, label: {
////            if gameVM.
////        })
//    }
    
}
//
//struct ActionBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActionBarView()
//    }
//}
