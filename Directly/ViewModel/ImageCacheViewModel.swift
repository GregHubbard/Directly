//
//  ImageCacheViewModel.swift
//  Directly
//
//  Created by Greg Hubbard on 2/11/23.
//

import Foundation
import SwiftUI

class ImageCacheViewModel: ObservableObject {
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString (string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject (image, forKey: NSString(string: forKey))
    }
}
