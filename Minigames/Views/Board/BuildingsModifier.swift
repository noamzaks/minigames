//
//  BuildingsModifier.swift
//  Minigames
//
//  Created by Tomer Israeli on 05/06/2021.
//

import SwiftUI

struct BuildingsOverlayModifier<Game>: ViewModifier where Game: SettlersGame{
    
    @ObservedObject var boardVM: BoardViewModel<Game>
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            ForEach(boardVM.buildings, id: \.self) { building in
                buildingView(for: building)
                    .frame(width: CGFloat(boardVM.radius), height: CGFloat( boardVM.radius))
                    .rotationEffect(.radians(building.angle))
                    .offset(offset(for: building))
                   
            }
            
            // drop previews
            roadDropPreview
            settlementDropPreview
           
            
            
//            ForEach(boardVM.harbors, id: \.self) { harbor in
//                HarborView<Game>(harbor: harbor)
//                    .offset(offset(for: harbor))
//
//            }
            
        }
            .environmentObject(boardVM)

    }
    
    @ViewBuilder
    private var roadDropPreview: some View {
        if let roadPath = boardVM.draggedRoadHoveringRoadPath {
            RoadView<Game>(for: boardVM.gameVM.localPlayer)
                .opacity(0.4)
                .rotationEffect(.radians(roadPath.angle))
                .offset(offset(for: roadPath))
        }
    }
    
    @ViewBuilder
    private var settlementDropPreview: some View {
        if let intersection = boardVM.draggedSettlementIntersection {
            SettlementView<Game>(for: boardVM.gameVM.localPlayer)
                .opacity(0.3)
                .offset(offset(for: intersection))
        }
    }
    
    @ViewBuilder
    private func buildingView(for building: Building) -> some View {
        switch building {
        case .city(_, let owner):
            CityView<Game>(for: owner)
        case .settelment(_, let owner):
            SettlementView<Game>(for: owner)
        case .road(_, let owner):
            RoadView<Game>(for: owner)
        }
    }
    
    private func offset<Position: BoardPosition>(for boardPosition: Position, RMult: Float = 1) -> CGSize {
        var position = boardPosition.boardPosition() * boardVM.radius * RMult
        // the building position is in a coordinate system where y axes is pointed up, unlike the screen coordinate system.
        position.reverseY()
        return position.asCGSize
    }
    
}

extension View {
    func buildingsOverlay<Game: SettlersGame> (_ boardVM: BoardViewModel<Game>) -> some View {
        
        self.modifier(BuildingsOverlayModifier(boardVM: boardVM))
        
    }
}
