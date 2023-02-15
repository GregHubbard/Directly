//
//  UrlImageViewModel.swift
//  Directly
//
//  Created by Greg Hubbard on 2/11/23.
//

import Foundation
import SwiftUI

class UrlImageViewModel: ObservableObject {
    @Published var image: UIImage?
    var urlString: String?
    var imageCache: ImageCacheViewModel
    
    init(urlString: String? = nil, imageCache: ImageCacheViewModel) {
        self.urlString = urlString
        self.imageCache = imageCache
        loadImage()
    }
    
    func loadImage() {
        if loadImageFromCache() {
            return
        }
        
        loadImageFromUrl()
    }
    
    func loadImageFromCache() -> Bool {
        guard let urlString = urlString else {
            return false
        }
        
        guard let cacheImage = imageCache.get(forKey: urlString) else {
            return false
        }
        
        image = cacheImage
        return true
    }
    
    func loadImageFromUrl() {
        guard let urlString = urlString else {
            return
        }
        
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url, completionHandler: getImageFromResponse(data: response: error: ))
        task.resume()
    }
    
    func getImageFromResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil else {
            return
        }
        guard let data = data else {
            return
        }
        
        DispatchQueue.main.async {
            guard let loadedImage = UIImage(data: data) else {
                return
            }
            
            self.imageCache.set(forKey: self.urlString!, image: loadedImage)
            self.image = loadedImage
        }
    }
}
