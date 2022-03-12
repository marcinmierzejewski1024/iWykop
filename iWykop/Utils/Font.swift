//
//  Font.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 06/03/2022.
//

import Foundation
import SwiftUI

extension Font {
    
    
    static func bodyFont() ->Font {
        return Font(uiFont: .bodyFont());
    }
    
    static func commentFont() ->Font {
        return Font(uiFont: .commentFont());
    }
}

extension UIFont {
    
    class func bodyFont() -> UIFont
    {
        return .systemFont(ofSize: 12);
    }

    class func commentFont() -> UIFont
    {
        return .systemFont(ofSize: 10);
    }

    
}

public extension Font {
  init(uiFont: UIFont) {
    self = Font(uiFont as CTFont)
  }
}


