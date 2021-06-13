//
//  VerticalTabView.swift
//  Minigames
//
//  Created by Tomer Israeli on 06/06/2021.
//

import SwiftUI

struct VerticalTabView<Contnet: View>: View {
    
    var content: () -> Contnet
    
    init(@ViewBuilder content: @escaping () -> Contnet) {
        self.content = content
    }
    
    var body: some View {
        GeometryReader{ geometry in
            
            TabView {
                content()
                    .rotationEffect(.degrees(-90)) // Rotate content
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height
                    )
            }
            .onAppear(perform: {
                UIScrollView.appearance().bounces = false
            })
            .frame(
                width: geometry.size.height, // Height & width swap
                height: geometry.size.width
            )
            .rotationEffect(.degrees(90), anchor: .topLeading) // Rotate TabView
            .offset(x: geometry.size.width) // Offset back into screens bounds
            .tabViewStyle(
                PageTabViewStyle(indexDisplayMode: .never)
            )
            
            
        }
        
    }
}

struct VerticalTabView_Previews: PreviewProvider {
    static var previews: some View {
        let colors: [Color] = [
            .red, .green, .blue, .gray
        ]
        
        return VerticalTabView {
            ForEach(colors, id: \.self) { color in
                color // Your cell content
            }
        }
    }
}
