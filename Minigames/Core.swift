import Foundation

extension Array {
    subscript(index: UInt) -> Element {
        get {
            self[Int(index)]
        }
        
        set(newElement) {
            self[Int(index)] = newElement
        }
    }
}
