//
//  Trade.swift
//  Minigames
//
//  Created by Tomer Israeli on 11/06/2021.
//

import Foundation

struct Trade: Identifiable {
    var id: UUID
    var bidderID: UUID
    var give: [Resource]
    var get: [Resource]
}
