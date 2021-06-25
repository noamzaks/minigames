//
//  GamePieceDropDelegate.swift
//  Minigames
//
//  Created by Tomer Israeli on 12/06/2021.
//

import SwiftUI
import Combine
import simd

class BoardViewModel<Game: SettlersGame>: HexagonStackViewModel {
    
    @Published var gameVM: SettlersGameViewModel<Game>
    private var cancellables: [AnyCancellable] = []
    
    //MARK: robber drag and drop
    @Published var DraggedRobberLocation: CGPoint = .zero
    var knightHoveringTile: (row: Int, column: Int)?
    var knightPositionIsValid: Bool {
        guard let pos = knightHoveringTile else { return false }
        return !(tileAt(pos.row, pos.column)?.knightIsIn ?? true)
    }
    
    //MARK: road drag and drop
    @Published var draggedRoadLocation: CGPoint = .zero
    var draggedRoadHoveringRoadPath:  RoadPath?
    var draggedRoadIsValid: Bool? {
        guard let pos = draggedRoadHoveringRoadPath else { return nil }
        return true // make real validation
    }
    
    //MARK: settlement drag and drop
    @Published var draggedSettlementLocation: CGPoint = .zero
    var draggedSettlementIntersection: Intersection?
    var draggedSettlementIsValid: Bool? {
        guard let pos = draggedSettlementIntersection else { return nil }
        return true // make real validation
    }
    
    init(gameVM: SettlersGameViewModel<Game>) {
        self.gameVM = gameVM
        super.init()
        
        $DraggedRobberLocation
            .map { self.closestTile(to: $0)?.gridPosition }
            .assign(to: \.knightHoveringTile, on: self)
            .store(in: &cancellables)
        
        $draggedRoadLocation
            .map { location in
                guard let tile = self.closestTile(to: location),
                      let dragPosition = self.boardPosition(of: location)
                else { return nil }
                
                let dPosition = tile.boardPosition() - dragPosition
                let side: TileSide = TileSide.allCases
                    .min { simd_length(($0.vector - dPosition)) > simd_length(($1.vector - dPosition)) }!
                
                return RoadPath(on: tile, at: side)
            }
            .assign(to: \.draggedRoadHoveringRoadPath, on: self)
            .store(in: &cancellables)
        
        
        $draggedSettlementLocation
            .map { location in
                guard let tile = self.closestTile(to: location),
                      let dragPosition = self.boardPosition(of: location)
                else { return nil }
                
                let dPosition = tile.boardPosition() - dragPosition
                let corner: TileCorner = TileCorner.allCases
                    .min { simd_length(($0.vector - dPosition)) > simd_length(($1.vector - dPosition)) }!
                
                return Intersection(on: tile, at: corner)
            }
            .assign(to: \.draggedSettlementIntersection, on: self)
            .store(in: &cancellables)
    }
    
    func tileAt(_ row: Int, _ column: Int) -> Tile? {
        gameVM.tiles.first { $0.row == row && $0.column == column }
    }
    
    var buildings: [Building] {
        gameVM.buildings
    }
    
    var harbors: [Harbor] {
        gameVM.harbors
    }
    
    private func closestTile(to point: CGPoint) -> Tile? {
        // find closest tile
        guard let boardPosition = boardPosition(of: point) else { return nil }
        
        return self.gameVM.tiles
            .sorted { distance($0.boardPosition(), boardPosition) < distance($1.boardPosition(), boardPosition) }
            .filter { distance($0.boardPosition(), boardPosition) < 1.1 } // hexagon side is the length of 1
            .first
    }
    
    private func boardPosition(of globalPosition: CGPoint) -> SIMD2<Float>? {
        //        let dragBoardPosition: SIMD2<Float> = .init(x: Float(point.x - frame.midX), y: Float(frame.midY - point.y)) / self.radius
        guard let frame = self.dimensions?.frame, frame.contains(globalPosition)
        else { return nil }
        
        return .init(x: Float(globalPosition.x - frame.midX), y: Float(frame.midY - globalPosition.y)) / self.radius
    }
    
    public func placeKnight(at location: CGPoint) {
        guard let tile = closestTile(to: location) else { return }
        
        
    }
 
    //MARK: UI supoort sizes and fonts
    var bigIconFont: Font   { .system(size: CGFloat(self.radius) * 0.36) }
    var smallIconFont: Font { .system(size: 0) }
    var diceValueFont: Font { .system(size: CGFloat(self.radius) * 0.3) }
    var textFont: Font      { .system(size: CGFloat(self.radius) * 0.2)}
    
    var setlementSize: CGFloat      { CGFloat(self.radius) * 0.35 }
    var probabilityDotSize: CGFloat { CGFloat(self.radius * 0.03) }
    var tagRadius: CGFloat          { CGFloat(self.radius * 0.66) }
    var shadowRadius: CGFloat       { CGFloat(self.radius * 0.1) }
    var roadSizes: (width: CGFloat, height: CGFloat, cornerRadius: CGFloat) {
        let r = CGFloat(self.radius)
        return (0.8 * r, 0.15 * r, 0.05 * r)
    }
}
