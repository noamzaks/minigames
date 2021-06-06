//
//  File.swift
//  Minigames
//
//  Created by Tomer Israeli on 05/06/2021.
//

import SwiftUI

struct BuildingView: View {
    
    var building: Building
    var tileRadius: Float
    
    var body: some View {
        Group {
            switch building {
            case .city(_):
                Circle()
                    .fill(Color.purple)
            case .settelment(_):
                Circle()
                    .fill(Color.blue)
            case .road(_):
                Text("ff")
            }
        }.frame(width: viewSize, height: viewSize)
    }
    
    private var viewSize: CGFloat {
        CGFloat(tileRadius) * BuildingView.tileRadiusMult
    }
    
    private static var tileRadiusMult: CGFloat = 0.35
}
