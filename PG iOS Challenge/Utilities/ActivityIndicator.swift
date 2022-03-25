//
//  ActivityIndicator.swift
//  PG iOS Challenge
//
//  Created by Eric Agredo on 3/24/22.
//

import SwiftUI


struct ActivityIndicator: UIViewRepresentable {
    typealias UIView = UIActivityIndicatorView
    var isAnimating: Bool
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIView { UIView() }
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<Self>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
       
    }
}
