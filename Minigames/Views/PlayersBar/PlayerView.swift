//
//  PlayerView.swift
//  Minigames
//
//  Created by Tomer Israeli on 03/06/2021.
//

import SwiftUI

struct PlayerView: View {
    
    @EnvironmentObject var player: Player
    var currentPlayerID: UUID?
    
    
    init(currentPlayerID: UUID?) {
        self.currentPlayerID = currentPlayerID
        
    }
    
    var body: some View {
        VStack {
            URLImageView(url: player.image, default: PlayerView.defaultProfile) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
            }
            
            Text(player.nickname)
                .font(.system(size: 12))
                .fontWeight(.bold)
                .frame(width: 80, height: 30)
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 25)
                    .stroke(borderColor, lineWidth: 2))
        .shadow(radius: 30)
    }
    
    var borderColor: Color {
        if player.id == currentPlayerID {
            return Color.green
        } else {
            return Color.clear
        }
    }
    
    private static let defaultProfile = "defaultProfileImage"
}


struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        
        let p = Player("Tomer Israeli", .red,  URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_j2VT552ZfuskH0mW56BCIONHRhyFhpGUUw&usqp=CAU"))
        
        return Group {
            PlayerView(currentPlayerID: nil)

            PlayerView(currentPlayerID: nil)
                .preferredColorScheme(.dark)
        }
        .environmentObject(p)
        .previewLayout(.fixed(width: 300, height: 300))
    }
}
