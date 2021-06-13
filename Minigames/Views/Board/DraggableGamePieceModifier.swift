//
//  DragableGamePieceView.swift
//  Minigames
//
//  Created by Tomer Israeli on 12/06/2021.
//

import SwiftUI

struct DraggableGamePieceModifier<Game: SettlersGame>: ViewModifier {
    
    @ObservedObject var boardVM: BoardViewModel<Game>
    @State private var dragAmount: CGSize = .zero
    init(_ boardVM: BoardViewModel<Game>) {
        self.boardVM = boardVM
    }
    
    func body(content: Content) -> some View {
        content
            .gesture(DragGesture(coordinateSpace: .global)
                        .onChanged {
                            self.dragAmount = $0.translation
                            self.boardVM.knightPosition = $0.location
                        }
                        .onEnded { _ in
                            self.dragAmount = .zero
                        })
            .offset(dragAmount)
            .zIndex(dragAmount == .zero ? 0 : 1)
    }
    
}

extension View {
    
    func draggableGamePiece<Game: SettlersGame>(_ boardVM: BoardViewModel<Game>) -> some View{
        self.modifier(DraggableGamePieceModifier(boardVM))
    }
    
}

struct DraggableGamePieceView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = BoardViewModel(gameVM: mocGameViewModel)
        
        return Text("cool")
            .draggableGamePiece(vm)
    }
}
