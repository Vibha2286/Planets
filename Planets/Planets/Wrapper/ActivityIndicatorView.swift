//
//  ActivityIndicatorView.swift
//  Planets
//
//  Created by Vibha Mangrulkar on 2021/11/19.
//

import SwiftUI

/// To display the activity indicator
struct ActivityIndicatorView: UIViewRepresentable {
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    
    /// Create the acitivty indicator view
    /// - Parameter context: current context
    /// - Returns: activity indicator view
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    /// Update the acitivity indicator for start and stop animating
    /// - Parameters:
    ///   - uiView: activity indicator view
    ///   - context: current context
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
