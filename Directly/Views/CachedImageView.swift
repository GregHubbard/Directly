//
//  CachedImageView.swift
//  Directly
//
//  Created by Greg Hubbard on 2/10/23.
//

import SwiftUI

struct CachedImageView: View {
    @ObservedObject var urlImageViewModel: UrlImageViewModel
    let size: CGFloat
    
    init(urlString: String?, imageCache: ImageCacheViewModel, size: CGFloat = 60) {
        urlImageViewModel = UrlImageViewModel(urlString: urlString, imageCache: imageCache)
        self.size = size
    }
    
    var body: some View {
        if urlImageViewModel.state == .loaded {
            Image(uiImage: urlImageViewModel.image!)
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size)
                .clipShape(Circle())
        } else {
            ZStack {
                Circle()
                    .fill(.gray.gradient)
                    .opacity(0.3)
                    .frame(width: size)
                
                ProgressView()
            }
        }
    }
}

struct CachedImageView_Previews: PreviewProvider {
    static var previews: some View {
        CachedImageView(urlString: nil, imageCache: ImageCacheViewModel())
    }
}
