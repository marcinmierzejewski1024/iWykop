//
//  Font.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 06/03/2022.
//

import Foundation
import SwiftUI

extension Font {
    

    static func titleFont() ->Font {
        return Font(uiFont: .titleFont());
    }
    
    static func largeFont() ->Font {
        return Font(uiFont: .largeFont());
    }
    
    static func bodyFont() ->Font {
        return Font(uiFont: .bodyFont());
    }
    
    static func commentFont() ->Font {
        return Font(uiFont: .commentFont());
    }
    
    static func loginFont() ->Font {
        return Font(uiFont: .loginFont());
    }
    
    static func settingsFont() ->Font {
        return Font(uiFont: .settingsFont());
    }
    
    static func dateFont() ->Font {
        return Font(uiFont: .dateFont());
    }
    
    static func countFont() ->Font {
        return Font(uiFont: .countFont());
    }
}

extension UIFont {

    
    class func titleFont() -> UIFont
    {
        return .systemFont(ofSize: 17, weight: .semibold);
    }
    
    class func largeFont() -> UIFont
    {
        return .systemFont(ofSize: 15, weight: .semibold);
    }

    class func bodyFont() -> UIFont
    {
        return .systemFont(ofSize: 12);
    }

    class func commentFont() -> UIFont
    {
        return .systemFont(ofSize: 12);
    }

    
    class func loginFont() -> UIFont
    {
        return .systemFont(ofSize: 13);
    }
    
    
    class func settingsFont() -> UIFont
    {
        return .systemFont(ofSize: 13);
    }

    
    class func dateFont() -> UIFont
    {
        return .systemFont(ofSize: 11);
    }
    
    class func countFont() -> UIFont
    {
        return .systemFont(ofSize: 13, weight: .bold);
    }

    
}

public extension Font {
  init(uiFont: UIFont) {
    self = Font(uiFont as CTFont)
  }
}


