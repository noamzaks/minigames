//
//  ResourceBarView.swift
//  Minigames
//
//  Created by Tomer Israeli on 03/06/2021.
//

import SwiftUI

struct ResourceBarView: View {
    
    @ObservedObject var player: Player
    
    var body: some View {
        HStack {
            ForEach(Resource.allCases){ resource in
                ResourceView(resource: resource)
            }
        }
        .environmentObject(player)        
    }
}

struct ResourceBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ResourceBarView(player: Player("cool"))
            
            ResourceBarView(player: Player("cool"))
                .preferredColorScheme(.dark)
        }
        .previewLayout(.fixed(width: 300, height: 3000))
    }
}
