//
//  RoadView.swift
//  Minigames
//
//  Created by Tomer Israeli on 19/06/2021.
//

import SwiftUI

struct RoadView: View {
    
    var owner: Player
    @EnvironmentObject var boardVM: BoardViewModel
    
    init(for owner: Player) {
        self.owner = owner
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Color(owner.color)
//            Color(owner.color)
//                .brightness(0.1)
        }
        .cornerRadius(boardVM.roadSizes.cornerRadius)
        .frame(width:   boardVM.roadSizes.width,
               height:  boardVM.roadSizes.height)
    }
}
