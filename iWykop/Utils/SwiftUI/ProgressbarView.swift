//
//  ProgressbarView.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 02/04/2022.
//


import SwiftUI

struct ProgressbarView: View {
    @EnvironmentObject var theme : WykopColors

    @State var value : Double;
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(theme.currentTheme.progressBarForeground)
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(theme.currentTheme.progressBarBackground)
            }.cornerRadius(15.0)
        }
    }
}
