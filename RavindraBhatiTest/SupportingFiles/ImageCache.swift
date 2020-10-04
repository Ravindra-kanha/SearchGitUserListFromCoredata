//
//  ImageCache.swift
//  RavindraBhatiTest
//
//  Created by Apple on 23/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//


import Foundation
import SwiftUI

/// ImageCache: To main the Cache Storage for the Image Loading.
class ImageCache {
    
    //MARK: Properties
    var cache = NSCache<NSString, UIImage>()
    
    
    /// Get Image  from the Cache Memory
    /// - Parameter forKey: to Identify the image using the key.
    /// - Returns: return the Proper  image on  from the cache storage.
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    
    /// set Image  in the Cache Memory.
    /// - Parameters:
    ///   - forKey: to Identify the image using the key.
    ///   - image:  save image in the cache storage.
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}

extension ImageCache {
    private static var imageCache = ImageCache()
    static func getImageCache() -> ImageCache {
        return imageCache
    }
}
