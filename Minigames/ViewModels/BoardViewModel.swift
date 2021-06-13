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
    
    @Published var knightPosition: CGPoint = .zero
    @Published var knightHoveringTile: (row: Int, column: Int)?
    
    private var cancellables: [AnyCancellable] = []
    
    init(gameVM: SettlersGameViewModel<Game>) {
        self.gameVM = gameVM
        super.init()
        
        $knightPosition
            .map { self.closestTile(to: $0) }
            .assign(to: \.knightHoveringTile, on: self)
            .store(in: &cancellables)
    }
    
    func tileAt(_ row: Int, _ column: Int) -> Tile? {
        gameVM.tiles.first { $0.row == row && $0.column == column }
    }
    
    //MARK: game piece drops
    
    private func closestTile(to point: CGPoint) -> (row: Int, column: Int)? {
        // find closest tile
        guard let frame = self.dimensions?.frame else { return nil }
        let dragBoardPosition: SIMD2<Float> = .init(x: Float(point.x - frame.midX), y: Float(frame.midY - point.y)) / self.radius
        
        let tile = self.gameVM.tiles
            .sorted {
                distance($0.boardPosition(), dragBoardPosition) < distance($1.boardPosition(), dragBoardPosition)
            }.first!
        
        if distance(tile.boardPosition(), dragBoardPosition) < self.radius * 0.6 {
            return (tile.row, tile.column)
        } else {
            return nil
        }
    }
    
}
