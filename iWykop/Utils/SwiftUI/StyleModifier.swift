//
//  StyleModifier.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 12/03/2022.
//

import SwiftUI

struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.titleFont())
            .foregroundColor(WykopColors.currentTheme.textColor)
    }
}

struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(WykopColors.currentTheme.cardColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct BackgroundStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(WykopColors.currentTheme.backgroundColor)
    }
}


struct BodyStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.bodyFont())
            .foregroundColor(WykopColors.currentTheme.textColor)
    }
}


struct CommentStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.commentFont())
            .foregroundColor(WykopColors.currentTheme.textColor)
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
    func body(content: Content) -> some View {
        content
            .font(Font.dateFont())
            .foregroundColor(WykopColors.currentTheme.secondaryTextColor)

    }
}

struct OtherTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.settingsFont())
            .foregroundColor(WykopColors.currentTheme.textColor)
    }
}


enum Margins : CGFloat {
    case small = 4.0
    case medium = 8.0
    case huge = 12.0
}
