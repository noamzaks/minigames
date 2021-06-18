//
//  GamePieceDropDelegate.swift
//  Minigames
//
//  Created by Tomer Israeli on 12/06/2021.
//

import SwiftUI
import Combine
import simd

class BoardViewModel<Game: SettlersGame>: HexagonStackViewModel, ObservableObject {
    
    @Published var gameVM: SettlersGameViewModel<Game>
    
    @Published var knightLocation: CGPoint = .zero
    var knightHoveringTile: (row: Int, column: Int)?
    var knightHoldingTime: Double = 0
    var knightPositionIsValid: Bool {
        guard let pos = knightHoveringTile else { return false }
        return !(tileAt(pos.row, pos.column)?.knightIsIn ?? true)
    }
    
    private var cancellables: [AnyCancellable] = []
    
    init(gameVM: SettlersGameViewModel<Game>) {
        self.gameVM = gameVM
        super.init()
        
        $knightLocation
            .map { self.closestTile(to: $0)?.gridPosition }
            .assign(to: \.knightHoveringTile, on: self)
            .store(in: &cancellables)
        
    }
    
    func tileAt(_ row: Int, _ column: Int) -> Tile? {
        gameVM.tiles.first { $0.row == row && $0.column == column }
    }
    
    //MARK: game piece drops
    private func closestTile(to point: CGPoint) -> Tile? {
        // find closest tile
        guard
            let frame = self.dimensions?.frame,
            frame.contains(point)
        else { return nil }
        
        let dragBoardPosition: SIMD2<Float> = .init(x: Float(point.x - frame.midX), y: Float(frame.midY - point.y)) / self.radius
        
        return self.gameVM.tiles
            .sorted { distance($0.boardPosition(), dragBoardPosition) < distance($1.boardPosition(), dragBoardPosition) }
            .filter { distance($0.boardPosition(), dragBoardPosition) < self.radius }
            .first
    }
    
    public func placeKnight(at location: CGPoint) {
        guard let tile = closestTile(to: location) else { return }
        
        
    }
    
}
