//
//  RemoteImageLoader.swift
//  RavindraBhatiSwiftApp
//
//  Created by Apple on 21/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//
import Foundation
import SwiftUI

/// RemoteImageLoader:- to load image on from the cache and from the Url of Image.
class RemoteImageLoader: ObservableObject {
    
    
    // MARK:- Properties
    
    
    /// to load image on the View.
    @Published var image: UIImage?
    
    /// Image url when load image from the url.
    var urlString: String?
    
    /// imageCache:- to maintain cache storage.
    var imageCache = ImageCache.getImageCache()
    
    
    /// Initialisation
    /// - Parameter urlString: Load image from the url ,
    init(urlString: String?) {
        self.urlString = urlString
        loadImage()
    }
    
    /// Load image in the Image object if available  in cache either from the url of image.
    func loadImage() {
        if loadImageFromCache() {
            return
        }
        loadImageFromUrl()
    }
    
    /// loadImageFromCache
    /// - Returns: when load image once and retrieve Second time to check if available in cache or not
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
    
    /// loadImageFromUrl:- Loader Image from the Url.
    func loadImageFromUrl() {
        guard let urlString = urlString else {
            return
        }
        
        if let url = URL(string: urlString){
            do {
                let task = URLSession.shared.dataTask(with: url, completionHandler: getImageFromResponse(data:response:error:))
                task.resume()
            } catch let error{
                print("Failed to save: ", error)
            }
        }
    }
    
    
    /// Get Image from the Response
    /// - Parameters:
    ///   - data: to Pass the Data of the Image.
    ///   - response: Get Exact Response of the Image.
    ///   - error:  if image is-loading from the url properly.
    func getImageFromResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil else {
            print("Error: \(error!)")
            return
        }
        guard let data = data else {
            print("No data found")
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
