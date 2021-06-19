//
//  BuildingsModifier.swift
//  Minigames
//
//  Created by Tomer Israeli on 05/06/2021.
//

import SwiftUI

struct BuildingsOverlayModifier<BuildingView, Game>: ViewModifier where BuildingView: View, Game: SettlersGame{
    
    @ObservedObject var boardVM: BoardViewModel<Game>
    var viewForBuilding: (Building) -> BuildingView
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            ForEach(boardVM.buildings, id: \.self) { building in
                viewForBuilding(building)
                    .frame(width: CGFloat(boardVM.radius), height: CGFloat( boardVM.radius))
                    .rotationEffect(.radians(building.angle))
                    .offset(offset(for: building))
                   
            }
            .environmentObject(boardVM)
        }
    }
    
    private func offset(for building: Building) -> CGSize {
        var position = building.position * boardVM.radius
        // the building position is in a coordinate system where y axes is pointed up, unlike the screen coordinate system.
        position.reverseY()
        return position.asCGSize
    }
    
}

extension HexagonStack {
    
    func buildingsOverlay<BuildingView: View, Game: SettlersGame> (_ boardVM: BoardViewModel<Game>, viewForBuilding: @escaping (Building) -> BuildingView) -> some View {
        
        self.modifier(BuildingsOverlayModifier(boardVM: boardVM, viewForBuilding: viewForBuilding))
        
    }
}
