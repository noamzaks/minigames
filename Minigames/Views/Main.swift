import SwiftUI

@main
struct MinigamesApp: App {
    var body: some Scene {
        WindowGroup {
            HexagonStack {_ in
                Text("cool")
            }
        }
    }
}

struct ResourceBar: View {
    @Environment(\.colorScheme) var scheme
    
    let resources: [Resource: UInt]
    
    var body: some View {
        HStack {
            ForEach(Resource.allCases) { resource in
                let icon = Resource.icons[resource.rawValue]
                let count = resources[resource] ?? 0
                
                Button(action: {}) {
                    Capsule()
                        .fill()
                        .overlay(Text("\(icon) \(count)").foregroundColor(scheme == .dark ? .black : .white))
                }.buttonStyle(PlainButtonStyle())
            }
        }
        .frame(maxHeight: 50)
        .padding()
    }
}

struct ResourceBarPreviews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            ResourceBar(resources: [.lumber: 2])
        }
            
        VStack {
            Spacer()
            ResourceBar(resources: [.lumber: 2])
        }
        .preferredColorScheme(.dark)
        
        Hexagon()
        
        Circle()
    }
}
