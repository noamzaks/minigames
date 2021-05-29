import SwiftUI

@main
struct MinigamesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct Hexagon: Shape {
    private static let margin = 0.2
    
    func path(in rect: CGRect) -> Path {
        let size = Double(min(rect.size.height, rect.size.width))
        var p = Path()
        
        p.move(to: CGPoint(x: 0, y: size * (1.0 - Hexagon.margin)))
        p.addLine(to: CGPoint(x: size / 2, y: size))
        p.addLine(to: CGPoint(x: size, y: size * (1.0 - Hexagon.margin)))
        p.addLine(to: CGPoint(x: size, y: size * Hexagon.margin))
        p.addLine(to: CGPoint(x: size / 2, y: 0))
        p.addLine(to: CGPoint(x: 0, y: size * Hexagon.margin))
        p.addLine(to: CGPoint(x: 0, y: size * (1.0 - Hexagon.margin)))
        
        return p
    }
}

struct Tile : View {
    let terrain: Terrain
    let size: CGFloat
    
    private static let backgrounds = ["Forest", "Hills", "Fields", "Pasture", "Mountains"]
    private static let border: CGFloat = 5
    
    var body: some View {
        ZStack {
            let shape = Hexagon()
            
            Rectangle()
                .background(Color.black)
                .frame(width: size, height: size)
                .clipShape(shape)
            
            Image(Tile.backgrounds[terrain.rawValue])
                .resizable()
                .frame(width: size - Tile.border, height: size - Tile.border)
                .clipShape(shape)
        }
    }
    
    enum Terrain: Int {
        case forest = 0
        case hills = 1
        case mountains = 2
        case fields = 3
        case pasture = 4
        // No backgrounds yet
        // case desert = 5
        // case gold = 6
        // case sea = 7
    }
}

struct ContentView : View {
    var body: some View {
        HStack {
            Tile(terrain: .forest, size: 100)
            Tile(terrain: .hills, size: 100)
            Tile(terrain: .mountains, size: 100)
        }
    }
}

#if DEBUG
struct ContentViewPreviews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
