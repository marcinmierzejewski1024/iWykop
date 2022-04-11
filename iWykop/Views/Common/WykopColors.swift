//
//  WykopColors.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 01/03/2022.
//

import Foundation
import SwiftUI


class WykopColors {
    static var currentTheme : Theme = WykopColorsLight();
    
    
}

protocol Theme {
    var accentColor: Color { get }
    var backgroundColor: Color { get }
    var plusGreenColor: Color { get }
    var cardColor: Color { get }
    var textColor: Color { get }
    var secondaryTextColor: Color { get }
    var authorColors : [Int:Color] { get }

    var progressBarForeground: Color { get }
    var progressBarBackground: Color { get }

    

}

class WykopColorsLight : Theme {
    
    var progressBarForeground: Color {
        get {
            return Color.blue;
        }

    }
    
    var progressBarBackground: Color {
        get {
            return Color.cyan;
        }

    }
    
    
    var accentColor : Color {
        get {
            return Color.indigo;
        }
    }

    var backgroundColor : Color {
        get {
            return .red;
//            return Color(red: 240, green: 240, blue: 240);
        }
    }
    
    var plusGreenColor : Color {
        get {
            return .green
        }
    }
    
    var cardColor : Color {
        
    
        get {
            return .yellow
//            return .white;
        }
    }
    
    
    var textColor : Color {
        get {
            return .black;
        }
    }
    
    var secondaryTextColor : Color {
        get {
            return Color(red: 40, green: 40, blue: 40);

        }
    }
    
    
    
    
    var authorColors : [Int:Color] {
        
        get {
            var result = [Int:Color]();
            result[0] = Color(rgb: 0x339933)
            result[1] = Color(rgb: 0xff5917)
            result[2] = Color(rgb: 0xBB0000)
            result[5] = Color(rgb: 0x000000)
       
            return result;
        }
        
    }
}


class WykopColorsDark : Theme {
    
    var progressBarForeground: Color {
        get {
            return Color.blue;
        }

    }
    
    var progressBarBackground: Color {
        get {
            return Color.cyan;
        }

    }
    

    
    var accentColor : Color {
        get {
            return Color.orange;
        }
    }

    var backgroundColor : Color {
        get {
            return Color(red: 40, green: 40, blue: 40);
        }
    }
    
    var plusGreenColor : Color {
        get {
            return .green
        }
    }
    
    var cardColor : Color {
        get {
            return .black;
        }
    }
    
    
    var textColor : Color {
        get {
            return .white;
        }
    }
    
    
    var secondaryTextColor : Color {
        get {
            return Color(red: 220, green: 220, blue: 220);

        }
    }
    
    
    
    
    var authorColors : [Int:Color] {
        
        get {
            var result = [Int:Color]();
            result[0] = Color(rgb: 0x339933)
            result[1] = Color(rgb: 0xff5917)
            result[2] = Color(rgb: 0xBB0000)
            result[5] = Color(rgb: 0x000000)
       
            return result;
        }
        
    }

}



extension Color {
    init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0)
   }

    init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
    
    public func hexDescription(_ includeAlpha: Bool = false) -> String {
        let uiColor = UIColor(self);
        guard uiColor.cgColor.numberOfComponents == 4 else {
            return "Color not RGB."
        }
        let a = uiColor.cgColor.components!.map { Int($0 * CGFloat(255)) }
        let color = String.init(format: "%02x%02x%02x", a[0], a[1], a[2])
        if includeAlpha {
            let alpha = String.init(format: "%02x", a[3])
            return "\(color)\(alpha)"
        }
        return color
    }
}
