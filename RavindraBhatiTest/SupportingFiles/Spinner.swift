//
//  Spinner.swift
//  RavindraBhatiSwiftApp
//
//  Created by Apple on 21/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI
import UIKit
import Combine


/// Spinner:- Spinner to show a loader when  data is loading.
struct Spinner: UIViewRepresentable {
    
    
    /// style: style of the animator Loader.
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: style)
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        return spinner
    }
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {}
}

