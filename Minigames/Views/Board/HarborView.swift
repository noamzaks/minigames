//
//  HarborView.swift
//  Minigames
//
//  Created by Tomer Israeli on 21/06/2021.
//

import SwiftUI

struct HarborView: View {
    
    var harbor: Harbor
    @EnvironmentObject var boardVM: BoardViewModel
    
    var body: some View {
        HStack(spacing: 0) {
            resourceList(of: harbor.get)
            Text(" : ")
            resourceList(of: harbor.give)
        }
            .padding(5)
            .background(Color.white)
            .clipShape(backgroundShape)
            .overlay(backgroundShape.stroke(Color.black, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/))
    }
    
    private var backgroundShape: some Shape {
        RoundedRectangle(cornerRadius: 10)
    }
    
    private func resourceList(of resources: [Resource]) -> some View {
        HStack {
            ForEach(Resource.allCases) { resource in
                if let amount = resources.count(of: resource), amount != 0 {
                    Text("\(amount) \(resource.icon)")
                }
            }
        }
        
    }
}
