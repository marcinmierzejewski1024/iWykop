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

struct ContentView: View {
    @State private var isPresented = false
    
    var body: some View {
        Button("Show Modal with full screen") {
            self.isPresented.toggle()
        }
        .fullScreenCover(isPresented: $isPresented, content: FullScreenModalView.init)
    }
}

struct FullScreenModalView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("This is a modal view")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            presentationMode.wrappedValue.dismiss()
        }
    }
}


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


