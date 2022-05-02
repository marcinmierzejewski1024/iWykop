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
            .foregroundColor(WykopColors.shared.currentTheme.textColor)
    }
}

struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(WykopColors.shared.currentTheme.cardColor)
//            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct BackgroundStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(WykopColors.shared.currentTheme.backgroundColor).ignoresSafeArea()
    }
}


struct BodyStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.bodyFont())
            .foregroundColor(WykopColors.shared.currentTheme.textColor)
    }
}


struct CommentStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.commentFont())
            .foregroundColor(WykopColors.shared.currentTheme.textColor)
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
            .foregroundColor(WykopColors.shared.currentTheme.secondaryTextColor)

    }
}

struct OtherTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.settingsFont())
            .foregroundColor(WykopColors.shared.currentTheme.textColor)
    }
}




enum Margins : CGFloat {
    case small = 6.0
    case medium = 10.0
    case huge = 14.0
}
