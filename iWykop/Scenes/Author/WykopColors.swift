//
//  WykopColors.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 01/03/2022.
//

import Foundation
import SwiftUI

class WykopColors {
    static var authorColors : [Int:Color] {
        
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
}