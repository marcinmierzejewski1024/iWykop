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

struct HTMLStringView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}
