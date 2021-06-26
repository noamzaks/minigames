//
//  BuildingsModifier.swift
//  Minigames
//
//  Created by Tomer Israeli on 05/06/2021.
//

import SwiftUI

struct BuildingsOverlayModifier: ViewModifier {
    
    @ObservedObject var boardVM: BoardViewModel
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            ForEach(boardVM.buildings, id: \.self) { building in
                buildingView(for: building)
                    .frame(width: CGFloat(boardVM.radius), height: CGFloat( boardVM.radius))
                    .rotationEffect(.radians(building.angle))
                    .offset(offset(for: building))
                   
            }
            
//            ForEach(boardVM.harbors, id: \.self) { harbor in
//                HarborView<Game>(harbor: harbor)
//                    .frame(width: CGFloat(boardVM.radius), height: CGFloat( boardVM.radius))
//                    .rotationEffect(.radians(harbor.path.angle), anchor: .bottom)
//                    .offset(offset(for: harbor))
//
//            }
            
            // drop previews
            roadDropPreview
            settlementDropPreview
            
            
            
        }
            .environmentObject(boardVM)

    }
    
    @ViewBuilder
    private var roadDropPreview: some View {
        if let roadPath = boardVM.draggedRoadHoveringRoadPath {
            RoadView(for: boardVM.gameVM.localPlayer)
                .opacity(0.4)
                .rotationEffect(.radians(roadPath.angle))
                .offset(offset(for: roadPath))
        }
    }
    
    @ViewBuilder
    private var settlementDropPreview: some View {
        if let intersection = boardVM.draggedSettlementIntersection {
            SettlementView(for: boardVM.gameVM.localPlayer)
                .opacity(0.3)
                .offset(offset(for: intersection))
        }
    }
    
    @ViewBuilder
    private func buildingView(for building: Building) -> some View {
        switch building {
        case .city(_, let owner):
            CityView(for: owner)
        case .settelment(_, let owner):
            SettlementView(for: owner)
        case .road(_, let owner):
            RoadView(for: owner)
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
    func buildingsOverlay(_ boardVM: BoardViewModel) -> some View {
        
        self.modifier(BuildingsOverlayModifier(boardVM: boardVM))
        
    }
}
