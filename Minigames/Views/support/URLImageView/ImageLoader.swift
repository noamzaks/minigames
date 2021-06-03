//
//  ImageLoader.swift
//  Minigames
//
//  Created by Tomer Israeli on 03/06/2021.
//

import Foundation
import Combine
import UIKit.UIImage

class ImageLoader: ObservableObject {
    
    enum LoadingState {
        case loading
        case failed(message: String)
        case loaded(image: UIImage)
    }
    
    @Published var loadingState: LoadingState
    private var cancellables: [AnyCancellable] = []

    init(url: URL?) {
        loadingState = .failed(message: "")
        guard let url = url else { return }
        self.loadImage(from: url)
    }
    
    
    private func loadImage(from url: URL){
        loadingState = .loading
        URLSession(configuration: .default)
            .dataTaskPublisher(for: url)
            .map { output in
                if let value = UIImage(data: output.data){
                    return .loaded(image: value)
                } else {
                    return .failed(message: output.response.debugDescription)
                }
            }
            .catch { error in
                Just(.failed(message: error.localizedDescription))
            }
            .receive(on: RunLoop.main)
            .assign(to: \.loadingState, on: self)
            .store(in: &cancellables)
    }
    
}
