//
//  DragableGamePieceView.swift
//  Minigames
//
//  Created by Tomer Israeli on 12/06/2021.
//

import SwiftUI

struct DraggableGamePieceModifier: ViewModifier {
    
    @Binding var location: CGPoint
    var onEnded: () -> Void
    
    @State private var dragAmount: CGSize = .zero
    
    init(_ location: Binding<CGPoint>, onEnded: @escaping () -> Void) {
        self._location = location
        self.onEnded = onEnded
    }
    
    func body(content: Content) -> some View {
        content
            .gesture(drag)
            .offset(self.dragAmount)
            .zIndex(dragAmount == .zero ? 0 : 1)
    }
    
    var drag: some Gesture {
        DragGesture(coordinateSpace: .global)
            .onChanged {
                self.dragAmount = $0.translation
                self.location = $0.location
            }
            
            .onEnded { data in
                onEnded()
                withAnimation {
                    self.dragAmount = .zero
                    self.location = data.location
                }
            }
    }
}

extension View {
    
    func draggableGamePiece(_ location: Binding<CGPoint>, onEnded: @escaping () -> Void) -> some View{
        self.modifier(DraggableGamePieceModifier(location, onEnded: onEnded))
    }
    
}
