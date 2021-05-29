import Foundation

struct Tile {
    let resource: Resource
    let dice: UInt
    
    // TODO: Keep track if building is a settlement or a city
    var buildings: [Int?] = Array<Int?>(repeating: nil, count: 6)
    var roads: [Int?] = Array<Int?>(repeating: nil, count: 6)
}
