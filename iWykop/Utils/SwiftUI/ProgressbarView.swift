//
//  ProgressbarView.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 02/04/2022.
//


import SwiftUI

struct ProgressbarView: View {
    @State var value : Double;
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(WykopColors.currentTheme.progressBarForeground)
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(WykopColors.currentTheme.progressBarBackground)
            }.cornerRadius(15.0)
        }
    }
}
