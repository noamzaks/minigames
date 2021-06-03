//
//  ResourceView.swift
//  Minigames
//
//  Created by Tomer Israeli on 02/06/2021.
//

import SwiftUI

struct ResourceView: View {
    
    @EnvironmentObject var player: Player
    var resource: Resource
    
    var body: some View {
        HStack {
            Text("\(resource.icon)")
            Text("\(player.resources.count(of: resource))")
        }
        .padding()
//        .background(Color(resource.matchedColor))
//        .background(Color.gray)
        .clipShape(Capsule())
        .overlay(Capsule()
                    .stroke(Color(resource.matchedColor), lineWidth: 2)
                    )
    
    }
}

fileprivate extension Resource {
    var icon: String {
        switch self {
        case .lumber:   return "🪵"
        case .brick:    return "🧱"
        case .grain:    return "🌾"
        case .wool:     return "🐑"
        case .ore:      return "🪨"
        }
    }
    
    var matchedColor: UIColor {
        switch self {
        case .lumber:   return UIColor(red: 0.3, green: 0.2, blue: 0.2, alpha: 1)
        case .brick:    return UIColor(red: 0.9, green: 0.45, blue: 0.4, alpha: 1)
        case .grain:    return UIColor(red: 0.9, green: 0.75, blue: 0.35, alpha: 1)
        case .wool:     return UIColor(red: 0.1, green: 0.6, blue: 0.1, alpha: 1)
        case .ore:      return UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        }
    }
}

struct ResourceView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HStack {
            ForEach(Resource.allCases) { resource in
                ResourceView(resource: resource)

            }
            }
            
            HStack {
            ForEach(Resource.allCases) { resource in
                ResourceView(resource: resource)

            }
            }
            .preferredColorScheme(.dark)
        }
            .previewLayout(.fixed(width: 500, height: 60))
            .environmentObject(Player("cool"))
    }
}
