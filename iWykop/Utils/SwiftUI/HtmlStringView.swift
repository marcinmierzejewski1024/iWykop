//
//  HtmlStringView.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 19/02/2022.
//

//import Foundation
//import SwiftUI


import WebKit
import SwiftUI


struct UIWKWebview: UIViewRepresentable {
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.scrollView.isScrollEnabled = false;
        uiView.load(URLRequest(url: URL(string: url)!))
    }
}



struct BackgroundBlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
