//
//  StyleModifier.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 12/03/2022.
//

import SwiftUI

struct TitleStyle: ViewModifier {
    @EnvironmentObject var theme : WykopColors

    
    func body(content: Content) -> some View {
        content
            .font(Font.titleFont())
            .foregroundColor(theme.currentTheme.textColor)
    }
}

struct CardStyle: ViewModifier {
    @EnvironmentObject var theme : WykopColors

    func body(content: Content) -> some View {
        content
            .background(theme.currentTheme.cardColor)
//            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct BackgroundStyle: ViewModifier {
    @EnvironmentObject var theme : WykopColors

    func body(content: Content) -> some View {
        content
            .background(theme.currentTheme.backgroundColor).ignoresSafeArea()
    }
}


struct BodyStyle: ViewModifier {
    @EnvironmentObject var theme : WykopColors

    func body(content: Content) -> some View {
        content
            .font(Font.bodyFont())
            .foregroundColor(theme.currentTheme.textColor)
    }
}



struct CountStyle: ViewModifier {
    @EnvironmentObject var theme : WykopColors

    func body(content: Content) -> some View {
        content
            .font(Font.countFont())
            .foregroundColor(theme.currentTheme.textColor)
    }
}



struct CommentStyle: ViewModifier {
    @EnvironmentObject var theme : WykopColors

    func body(content: Content) -> some View {
        content
            .font(Font.commentFont())
            .foregroundColor(theme.currentTheme.textColor)
    }
}


struct LoginStyle: ViewModifier {

    let loginColor : Color;
    func body(content: Content) -> some View {
        content
            .font(Font.loginFont()).foregroundColor(loginColor)
    }
}

struct DateStyle: ViewModifier {
    @EnvironmentObject var theme : WykopColors

    func body(content: Content) -> some View {
        content
            .font(Font.dateFont())
            .foregroundColor(theme.currentTheme.secondaryTextColor)

    }
}

struct OtherTextStyle: ViewModifier {
    @EnvironmentObject var theme : WykopColors

    func body(content: Content) -> some View {
        content
            .font(Font.settingsFont())
            .foregroundColor(theme.currentTheme.textColor)
    }
}




enum Margins : CGFloat {
    case tiny = 3.0

    case small = 6.0
    case medium = 10.0
    case huge = 14.0
    case responseOffset = 25.0
}

enum MaxSizes : CGFloat {
    case previewWidth = 440.0
    case previewHeight = 340.0
    case profileThumbsize = 38.0

}





