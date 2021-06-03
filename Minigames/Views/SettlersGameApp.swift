import SwiftUI

@main
struct MinigamesApp: App {
    
    @ObservedObject var viewModel: SettlersGameViewModel<LocalSettlersGame>
    
    init() {
        viewModel = mocGameViewModel
    }
    
    var body: some Scene {
        WindowGroup {
            GameView(gameVM: viewModel)
        }
    }
}
