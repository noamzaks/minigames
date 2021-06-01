import SwiftUI

@main
struct MinigamesApp: App {
    var body: some Scene {
        WindowGroup {
            HexagonStack {_,_,_  in
                Text("cool")
            }
        }
    }
}
//
//struct ResourceBar: View {
//    @Environment(\.colorScheme) var scheme
//    
//    let resources: [Resource: UInt]
//    
//    var body: some View {
//        HStack {
//            ForEach(Resource.allCases) { resource in
//                let icon = Resource.icons[resource.rawValue]
//                let count = resources[resource] ?? 0
//                
//                Button(action: {}) {
//                    Capsule()
//                        .fill()
//                        .overlay(Text("\(icon) \(count)").foregroundColor(scheme == .dark ? .black : .white))
//                }.buttonStyle(PlainButtonStyle())
//            }
//        }
//        .frame(maxHeight: 50)
//        .padding()
//    }
//}
//
//struct ResourceBarPreviews: PreviewProvider {
//    static var previews: some View {
//        VStack {
//            Spacer()
//            ResourceBar(resources: [.lumber: 2])
//        }
//            
//        VStack {
//            Spacer()
//            ResourceBar(resources: [.lumber: 2])
//        }
//        .preferredColorScheme(.dark)
//        
//        Hexagon()
//        
//        Circle()
//    }
//}

//    //MARK: constants
//
//    private static let playerInitialResources: [Resource] = {
//        var resources = Array<Resource>()
//        resources.append(contentsOf: repeatElement(Resource.lumber  , count: 4))
//        resources.append(contentsOf: repeatElement(Resource.brick   , count: 3))
//        resources.append(contentsOf: repeatElement(Resource.grain   , count: 4))
//        resources.append(contentsOf: repeatElement(Resource.wool    , count: 4))
//        resources.append(contentsOf: repeatElement(Resource.ore     , count: 3))
//        return resources
//    }()
//
//    private static let bankInitialResources: [Resource] = {
//        var resources = Array<Resource>()
//        resources.append(contentsOf: repeatElement(Resource.lumber  , count: 4))
//        resources.append(contentsOf: repeatElement(Resource.brick   , count: 3))
//        resources.append(contentsOf: repeatElement(Resource.grain   , count: 4))
//        resources.append(contentsOf: repeatElement(Resource.wool    , count: 4))
//        resources.append(contentsOf: repeatElement(Resource.ore     , count: 3))
//        return resources
//    }()
//
//    private static let boardTerrains: [Terrain] = {
//        var tiles = Array<Terrain>()
//        tiles.append(contentsOf: repeatElement(Terrain.desert   , count: 1))
//        tiles.append(contentsOf: repeatElement(Terrain.pasture  , count: 4))
//        tiles.append(contentsOf: repeatElement(Terrain.fields   , count: 4))
//        tiles.append(contentsOf: repeatElement(Terrain.mountains, count: 3))
//        tiles.append(contentsOf: repeatElement(Terrain.forest   , count: 4))
//        tiles.append(contentsOf: repeatElement(Terrain.hills    , count: 3))
//        return tiles
//    }()
//
//    private static let boardDiceValues: [(value: Int, probability: Int)] = {
//        var values = Array<(value: Int, probability: Int)>()
//        values.append(contentsOf: repeatElement((value: 2   , probability: 1), count: 1))
//        values.append(contentsOf: repeatElement((value: 3   , probability: 2), count: 2))
//        values.append(contentsOf: repeatElement((value: 4   , probability: 3), count: 2))
//        values.append(contentsOf: repeatElement((value: 5   , probability: 4), count: 2))
//        values.append(contentsOf: repeatElement((value: 6   , probability: 5), count: 2))
//        values.append(contentsOf: repeatElement((value: 8   , probability: 5), count: 2))
//        values.append(contentsOf: repeatElement((value: 9   , probability: 4), count: 2))
//        values.append(contentsOf: repeatElement((value: 10  , probability: 3), count: 2))
//        values.append(contentsOf: repeatElement((value: 11  , probability: 2), count: 2))
//        values.append(contentsOf: repeatElement((value: 12  , probability: 1), count: 1))
//        return values
//    }()
//
//    private static let minAmountOfColumns: Int = 3
//    private static let maxAmountOfColumns: Int = 5
//
//    private static let boardPosition: [(row: Int, column: Int)] = {
//        var positions = Array<(row: Int, column: Int)>()
//
//        let numberOfRows = (maxAmountOfColumns - minAmountOfColumns) * 2 + 1
//        var currentAmountOfColumns: Int = minAmountOfColumns
//        var maxAmountOfColumnsAchived: Bool = false
//        for row in 0..<numberOfRows {
//            for column in 0..<currentAmountOfColumns {
//                positions.append((row, column))
//            }
//            currentAmountOfColumns += maxAmountOfColumnsAchived ? -1 : 1
//            if currentAmountOfColumns == maxAmountOfColumns {
//                maxAmountOfColumnsAchived = true
//            }
//        }
//
//        return positions
//    }()
//
