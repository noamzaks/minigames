//
//  URLImageView.swift
//  Minigames
//
//  Created by Tomer Israeli on 03/06/2021.
//

import SwiftUI
import Combine

struct URLImageView<ImageView: View>: View {
    
    @ObservedObject var imageLoader: ImageLoader
    
    var defaultImage: UIImage
    var viewForImage: (Image) -> ImageView
    init(url: URL?, default defaultImage: UIImage, _ viewForImage: @escaping (Image) -> ImageView) {
        self.defaultImage = defaultImage
        imageLoader = ImageLoader(url: url)
        self.viewForImage = viewForImage
    }
    
    init(url: URL?, default imageName: String, viewForImage: @escaping (Image) -> ImageView){
        self.init(url: url, default: UIImage(named: imageName)!, viewForImage)
    }
    
    var body: some View{
        Group {
            switch imageLoader.loadingState {
            case .loading:
                ProgressView()
            case .failed(_):
                viewForImage(Image(uiImage: defaultImage))
//                   Text(message)
            case .loaded(let image):
                viewForImage(Image(uiImage: image))
            }
        }
    }
    
    
}

struct URLImageView_Previews: PreviewProvider {
    static var previews: some View {
        URLImageView(url: URL(string: "https://cdn.searchenginejournal.com/wp-content/uploads/2019/08/c573bf41-6a7c-4927-845c-4ca0260aad6b-760x400.jpeg")!, default: "BricksBackground") { image in
            image
                .clipShape(Circle())
            
        }
    }
}
