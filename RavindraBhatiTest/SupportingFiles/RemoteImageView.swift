//
//  RemoteImageView.swift
//  RavindraBhatiSwiftApp
//
//  Created by Apple on 20/08/20.
//  Copyright © 2020 Apple. All rights reserved.

import SwiftUI
import Foundation

//MARK: RemoteImageView:- Show Image on the View from the url.
struct RemoteImageView: View {
    
    //MARK: Properties
    
    ///remoteImageLoader:-  to retrieve information of cache and render view on the image.
    @ObservedObject var remoteImageLoader: RemoteImageLoader
    
    /// imageWidth:- Default size of the image.
    var imageWidth: CGFloat? = 30
    
    
    /// defaultImage:- Default image to show  as place holder on the image
    static var defaultImage = UIImage(systemName: "person.circle.fill")
    
    /// Initialisation
    /// - Parameters:
    ///   - urlString: get url of the Image to render image on the View.
    ///   - width: size of the image if user want to be resize the image.
    init(urlString: String?, width: CGFloat) {
        remoteImageLoader = RemoteImageLoader(urlString: urlString)
        imageWidth = width
    }
    
    /// Body:- get image after retrieve information from the Remote Image Loader.
    var body: some View {
        Image(uiImage: remoteImageLoader.image ?? RemoteImageView.defaultImage!)
            .renderingMode(.original)
            .resizable()
            .scaledToFit()
            .frame(width: imageWidth, height: imageWidth)
    }
}


