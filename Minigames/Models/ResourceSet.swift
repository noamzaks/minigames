import Foundation

struct ResourceSet {
    private var resources: [UInt]
    
    init() {
        resources = [UInt](repeating: 0, count: Resource.allCases.count)
    }
    
    init(from dictionary: [Resource: UInt]) {
        resources = [UInt](repeating: 0, count: Resource.allCases.count)
        
        for (resource, count) in dictionary {
            add(count, of: resource)
        }
    }
    
    subscript(index: Resource) -> UInt {
        resources[index.rawValue]
    }
    
    func contains(set other: ResourceSet) -> Bool {
        for resource in Resource.allCases {
            if self[resource] < other[resource] { return false }
        }
        
        return true
    }
    
    func contains(dictionary: [Resource: UInt]) -> Bool {
        for (resource, count) in dictionary {
            if self[resource] < count { return false }
        }
        
        return true
    }
    
    func asDictionary() -> [Resource: UInt] {
        var result = [Resource: UInt]()
        for resource in Resource.allCases {
            let current = self[resource]
            if current != 0 {
                result[resource] = current
            }
        }
        return result
    }
    
    mutating func add(_ count: UInt, of resource: Resource) {
        resources[resource.rawValue] += count
    }
    
    mutating func subtract(_ count: UInt, of resource: Resource) {
        resources[resource.rawValue] -= count
    }
    
    mutating func pay(set other: ResourceSet) -> Bool {
        if !contains(set: other) { return false }
        
        for resource in Resource.allCases {
            subtract(other[resource], of: resource)
        }
        
        return true
    }
    
    mutating func pay(dictionary: [Resource: UInt]) -> Bool {
        if !contains(dictionary: dictionary) { return false }
        
        for (resource, count) in dictionary {
            subtract(count, of: resource)
        }
        
        return true
    }
    
    static func +(left: ResourceSet, right: ResourceSet) -> ResourceSet {
        var result = ResourceSet()
        
        for resource in Resource.allCases {
            result.add(left[resource] + right[resource], of: resource)
        }
        
        return result
    }
    
    static func +=(left: inout ResourceSet, right: ResourceSet) {
        for resource in Resource.allCases {
            left.add(right[resource], of: resource)
        }
    }
    
    static func >=(left: ResourceSet, right: ResourceSet) -> Bool {
        return left.contains(set: right)
    }
    
    static func >=(left: ResourceSet, right: [Resource: UInt]) -> Bool {
        return left.contains(dictionary: right)
    }
    
    static func <(left: ResourceSet, right: ResourceSet) -> Bool {
        return !(left >= right)
    }
    
    static func <(left: ResourceSet, right: [Resource: UInt]) -> Bool {
        return !(left >= right)
    }
}
