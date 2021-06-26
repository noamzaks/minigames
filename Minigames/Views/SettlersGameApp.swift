import SwiftUI

@main
struct MinigamesApp: App {
    
    @ObservedObject var viewModel: SettlersGameViewModel
    
    init() {
        viewModel = mocGameViewModel
    }
    
    var body: some Scene {
        WindowGroup {
            GameView(viewModel)
        }
    }
}
