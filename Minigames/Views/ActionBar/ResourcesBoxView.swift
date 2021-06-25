//
//  ResourcesBoxView.swift
//  Minigames
//
//  Created by Tomer Israeli on 23/06/2021.
//

import SwiftUI

struct ResourcesBoxView: View {
    
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

struct ResourcesBoxView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ResourcesBoxView(player: Player("cool"))
            
            ResourcesBoxView(player: Player("cool"))
                .preferredColorScheme(.dark)
        }
        .previewLayout(.fixed(width: 500, height: 300))
    }
}
