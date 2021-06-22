//
//  Zoomable.swift
//  Minigames
//
//  Created by Tomer Israeli on 22/06/2021.
//

import SwiftUI

struct ZoomableModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        ZStack {
        content
            .scaleEffect(zoomScale)
            .offset(offset)
            .gesture(dragGesture())
            .gesture(pinchGesture())
            .gesture(doubleTapGesture())
        }
    }
    
    
    //MARK: zoom gesture
    @State private var steadyZoomScale: CGFloat = 1.0
    @GestureState private var gestureZoomScale: CGFloat = 1.0
    
    var zoomScale: CGFloat { steadyZoomScale * gestureZoomScale }
    
    private func pinchGesture() -> some Gesture{
        MagnificationGesture()
            .updating($gestureZoomScale) { value, gestureState, _ in
                gestureState = value
            }
            .onEnded { value in
                steadyZoomScale *= value
            }
    }
    
    //MARK: offset gesture
    @State private var steadyOffset: CGSize = .zero
    @GestureState private var gestureOffset: CGSize = .zero
    
    var offset: CGSize { (steadyOffset + gestureOffset) * zoomScale }
    
    private func dragGesture() -> some Gesture {
        DragGesture()
            .updating($gestureOffset) { value, gestureState, _ in
                gestureState = value.translation / self.zoomScale
            }
            .onEnded { value in
                steadyOffset = steadyOffset + (value.translation / self.zoomScale)
            }
    }
    
    //MARK: double tap to reset gesture
    private func doubleTapGesture() -> some Gesture {
        TapGesture(count: 2)
            .onEnded {
                withAnimation {
                    self.steadyOffset = .zero
                    self.steadyZoomScale = 1.0
                }
            }
    }
}


extension View {
    
    public func zoomable() -> some View {
        self.modifier(ZoomableModifier())
    }
    
}

struct Zoomable_Previews: PreviewProvider {
    static var previews: some View {
        
        VStack(spacing: 10) {
            Text("cool")
                .frame(width: 200, height: 200)
                .background(Color.red)
                .modifier(ZoomableModifier())
            
            Text("cool")
                .frame(width: 200, height: 200)
                .background(Color.blue)
        }
        .previewDevice("iPhone 11")
        
    }
}
