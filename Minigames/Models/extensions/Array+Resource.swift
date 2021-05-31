//
//  Array+Resource.swift
//  Minigames
//
//  Created by Tomer Israeli on 31/05/2021.
//

import Foundation

extension Array where Element == Resource{
    
    func count(of resource: Resource) -> Int {
        self.filter{ $0 == resource }.count
    }
    
}
