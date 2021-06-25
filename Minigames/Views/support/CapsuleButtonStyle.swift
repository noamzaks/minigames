//
//  CapsuleButtonStyle.swift
//  Minigames
//
//  Created by Tomer Israeli on 24/06/2021.
//

import SwiftUI

struct CapsuleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .opacity(configuration.isPressed ? 0.6 : 1)
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

