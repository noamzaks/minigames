//
//  GameStateView.swift
//  Minigames
//
//  Created by Tomer Israeli on 24/06/2021.
//

import SwiftUI

struct GameStateView<Game: SettlersGame>: View {
    
    @EnvironmentObject var board: BoardViewModel<Game>
    
    var body: some View {
        switch self.board.gameVM.gameState {
        case .ended(let winner):
            gameEndedView(winner)
        case .localPlayerTurn(let showRobber, let diceRolled):
            playerTurnView(showRobber: showRobber, diceRolled: diceRolled)
        case .remotePlayerTurn(let player):
            remotePlayerTurnView(player)
        case .localPlayerFirstTurn:
            Text("local player first turn")
        case .waitingForPlayers(_):
            waitingForPlayersView()
        }
    }
    
    @ViewBuilder
    private func waitingForPlayersView() -> some View {
        VStack {
            Text("Looking For Players")
                .font(.headline)
                .fontWeight(.bold)
            ProgressView()
        }
        
    }
    
    @ViewBuilder
    private func gameEndedView(_ winner: Player?) -> some View {
        if let winner = winner {
            PlayerView(player: winner, "has won the game")
            
        } else {
            VStack {
                Text("The Game Has Ended")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text("nobody has won")
            }
        }
    }
    
    @ViewBuilder
    private func playerTurnView(showRobber: Bool, diceRolled: Bool) -> some View {
        if !diceRolled {
            Button(action: {
                
            }, label: {
                Label(
                    title: {
                        Text("Roll Dice")
                    }, icon: {
                        Image("DiceImage")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                )
            })
            .buttonStyle(CapsuleButtonStyle())
        } else if showRobber {
            ZStack{
                DraggableRobberView(boardVM: board)
                VStack {
                    Spacer()
                    Text("Drag and Place The Robber")
                        .font(.footnote)
                }
                
            }
        } else {
            Button(action: {
                
            }, label: {
                Text("Finish Turn")
            })
            .buttonStyle(CapsuleButtonStyle())
            
        }
    }
    
    @ViewBuilder
    private func remotePlayerTurnView(_ player: Player) -> some View {
        PlayerView(player: player, "is now playing")
    }
}


//struct GameStateView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            GameStateView<LocalSettlersGame>(gameState: .constant(.ended(winner: Player("Tomer"))))
//            GameStateView<LocalSettlersGame>(gameState: .constant(.ended(winner: nil)))
//            GameStateView<LocalSettlersGame>(gameState: .constant(.localPlayerTurn(placeKnight: true, diceRolled: false)))
//            GameStateView<LocalSettlersGame>(gameState: .constant(.localPlayerTurn(placeKnight: true, diceRolled: true)))
//            GameStateView<LocalSettlersGame>(gameState: .constant(.localPlayerTurn(placeKnight: false, diceRolled: true)))
//            GameStateView<LocalSettlersGame>(gameState: .constant(.remotePlayerTurn(player: Player("remote player"))))
//            GameStateView<LocalSettlersGame>(gameState: .constant(.waitingForPlayers(connectedPlayers: [Player("player 1")])))
//        }
//        .environmentObject(BoardViewModel(gameVM: mocGameViewModel))
//        .previewLayout(.fixed(width: 300, height: 100))
//        .preferredColorScheme(.dark)
//        
//    }
//}

