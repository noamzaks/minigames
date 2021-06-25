//
//  PlayerView.swift
//  Minigames
//
//  Created by Tomer Israeli on 03/06/2021.
//

import SwiftUI

struct PlayerView: View {
    
    @ObservedObject var player: Player
    var additionalText: String
    
    init(player: Player, _ text: String = "") {
        self.player = player
        self.additionalText = text
    }
    
    var body: some View {
        
        
        HStack(alignment: .top) {
            URLImageView(url: player.image, default: PlayerView.defaultProfile) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(imageShape)
                    .overlay(imageShape.stroke(Color(player.color), lineWidth: 2))
            }
            
            VStack(alignment: .leading) {
                Text(player.nickname)
                    .font(.headline)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 20)
                
                Text(additionalText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(width: 200)
    }
    
    
    var imageShape: some Shape {
        RoundedRectangle(cornerRadius: 15, style: .continuous)
    }
    
    private static let defaultProfile = "defaultProfileImage"
}


struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        
        let p = Player("Tomer Israeli", .red,  URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_j2VT552ZfuskH0mW56BCIONHRhyFhpGUUw&usqp=CAU"))
        
        return Group {
            PlayerView(player: p)
            
            PlayerView(player: p)
                .preferredColorScheme(.dark)
        }
        .environmentObject(p)
        .previewLayout(.fixed(width: 300, height: 300))
    }
}
