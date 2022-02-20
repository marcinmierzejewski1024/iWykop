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
    let htmlContent: NSAttributedString

    func makeUIView(context: Context) -> UILabel {
        return UILabel()
    }

    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.numberOfLines = 44;
        uiView.attributedText = htmlContent//.htmlToAttributedString;
        uiView.sizeToFit();
    }
}


