//
//  CachedImageView.swift
//  Directly
//
//  Created by Greg Hubbard on 2/10/23.
//

import SwiftUI

struct CachedImageView: View {
    @ObservedObject var viewModel: CachedImageViewModel
    let size: CGFloat
    
    init(urlString: String?, size: CGFloat) {
        viewModel = CachedImageViewModel(urlString: urlString)
        self.size = size
    }
    
    var body: some View {
        if viewModel.image != nil {
            Image(uiImage: viewModel.image!)
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size)
                .clipShape(Circle())
        } else {
            Circle()
                .frame(width: size)
                .foregroundColor(.gray)
        }
    }
}

struct CachedImageView_Previews: PreviewProvider {
    static var previews: some View {
        CachedImageView(urlString: nil, size: 100)
    }
}
