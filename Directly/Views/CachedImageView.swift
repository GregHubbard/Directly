//
//  CachedImageView.swift
//  Directly
//
//  Created by Greg Hubbard on 2/10/23.
//

import SwiftUI

struct CachedImageView: View {
    @ObservedObject var urlImageViewModel: UrlImageViewModel
    let size: CGFloat = 60
    
    init(urlString: String?, imageCache: ImageCacheViewModel) {
        urlImageViewModel = UrlImageViewModel(urlString: urlString, imageCache: imageCache)
    }
    
    var body: some View {
        if urlImageViewModel.image != nil {
            Image(uiImage: urlImageViewModel.image!)
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size)
                .clipShape(Circle())
        } else {
            Circle()
                .fill(.gray.gradient)
                .opacity(0.3)
                .frame(width: size)
        }
    }
}

struct CachedImageView_Previews: PreviewProvider {
    static var previews: some View {
        CachedImageView(urlString: nil, imageCache: ImageCacheViewModel())
    }
}
