//
//  UIImage.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 01/08/2022.
//

import Foundation
import UIKit


extension UIImage {
    func getPixelColor(pos: CGPoint) -> UIColor {

        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)

        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4

        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)

        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    func isImageDataMalformed() -> Bool {
        
        let lastPixelColor = self.getPixelColor(pos: CGPoint(x: self.size.width - 1, y: self.size.height - 1));
        print("lastpixelcolor \(lastPixelColor)")
        return lastPixelColor == UIColor.gray;//TODO:to verify
    }

}
