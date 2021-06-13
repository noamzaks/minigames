//
//  DiceView.swift
//  Minigames
//
//  Created by Tomer Israeli on 09/06/2021.
//

import SwiftUI

struct DiceView: View {
    
    @State var angleX: Double = 60
    var op: Double = 1
    
    var body: some View {
        VStack {
        HStack {
            Text("1")
                .frame(width: 100, height: 100, alignment: .center)
                .background(Color.white)
                .rotation3DEffect(
                    .degrees(angleX),
                    axis: (x: 1.0, y: 0.0, z: 0.0),
                    anchor: .center,
                    anchorZ: -50,
                    perspective: 0
                )
//                .opacity.(opacity(for: angleX))

            Text("2")
                .frame(width: 100, height: 100, alignment: .center)
                .background(Color.white)
                .rotation3DEffect(
                    .degrees(angleX + 90),
                    axis: (x: 1.0, y: 0.0, z: 0.0),
                    anchor: .center,
                    anchorZ: -50,
                    perspective: 0
                )
//                .opacity(opacity(for: angleX + 90))
                .overlay(Text("\(an(angleX))"))


            Text("3")
                .frame(width: 100, height: 100, alignment: .center)
                .background(Color.white)
                .rotation3DEffect(
                    .degrees(angleX + 180),
                    axis: (x: 1.0, y: 0.0, z: 0.0),
                    anchor: .center,
                    anchorZ: -50,
                    perspective: 0
                )
//                .opacity(opacity(for: angleX + 180 ))


            Text("4")
                .frame(width: 100, height: 100, alignment: .center)
                .background(Color.white)
                .rotation3DEffect(
                    .degrees(angleX + 270),
                    axis: (x: 1.0, y: 0.0, z: 0.0),
                    anchor: .center,
                    anchorZ: -50,
                    perspective: 0
                )
//                .opacity(opacity(for: angleX + 290))


        }
        .onAppear {
            angleX = 0
        }
        .onTapGesture {
            withAnimation(.linear(duration: 8)){
                angleX += 270
            }
        }
        .shadow(radius: 2)
     
            Slider(value: $angleX, in: -360...360)
        }
        
    }
    
    func an(_ angle: Double) -> Double {
        var a = angle.remainder(dividingBy: 360)
        if a < 0 { a += 360 }
        return a
    }
    
    func opacity(for angle: Double) -> Double {
        let a = an(angle)
        if a >= 270{ return 0}
        return 1
    }
    
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView()
            .previewDevice("iPhone 8")
    }
}

