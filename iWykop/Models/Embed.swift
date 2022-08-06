////
////  Embed.swift
////  iWykop
////
////  Created by Marcin Mierzejewski on 18/02/2022.
////
//
import Foundation

// sourcery: AutoInit
class Embed: AutoCodable, AutoEquatable {
    var source: String = ""
    var plus18: Bool = false
    var preview: String = ""
    var animated: Bool = false
    // sourcery: skipPersistance
    var type: TypeEnum?
    var ratio: Double = 0.0
    // sourcery: primaryKey
    var url: String = ""
    var size: String?
    
    
    func getThumbnailImageURL() -> String? {
        if(self.type == .image) {
            let thumbnail = self.url;
            return thumbnail.replacingOccurrences(of: ".jpg", with: ",w250.jpg");
        } else {
            return self.preview;
        }
        
        
    }
    
    
    func getFullImageUrl() -> String {
        return url;

    }
    
    func getAnimatedImageUrl() ->String? {
        
        if self.animated {
            return url.replacingOccurrences(of: ".jpg", with: ".gif");//wykop apiv2 nonsense
        }
        
        return nil;
    }
    
    func getSourceDomain() -> String? {
        if let url = URL(string: self.url) {
            return url.host?.replacingOccurrences(of: "www.", with: "")
        }
        
        return nil;
    }
    
    
    func nativePlayerByDomain() -> Bool {
        let nativeDomains = ["gfycat", "streamable", "coub", "youtu"];

        for nativeDomain in nativeDomains {
            if(self.getSourceDomain()?.contains(nativeDomain) ?? false) {
                return true;
            }
        }
        
        return false;
    }
    
    func label() -> String? {
        if(animated){
            return "GIF";
        }
        if(self.getSourceDomain()?.contains("gfycat") ?? false) {
            return "GFY";
        }
        if(self.getSourceDomain()?.contains("youtu") ?? false) {
            return "YT";
        }
        if(self.getSourceDomain()?.contains("streamable") ?? false) {
            return "STREAMABLE";
        }
        if(self.getSourceDomain()?.contains("coub") ?? false) {
            return "COUB";
        }

        
        return nil;
        
    }



// sourcery:inline:auto:Embed.AutoInit


    internal init(source: String, plus18: Bool, preview: String, animated: Bool, type: TypeEnum?, ratio: Double, url: String, size: String?) { // swiftlint:disable:this line_length


        self.source = source


        self.plus18 = plus18


        self.preview = preview


        self.animated = animated


        self.type = type


        self.ratio = ratio


        self.url = url


        self.size = size


    }
// sourcery:end
}


enum TypeEnum: String, Codable {
    
    
    case image = "image"
    case video = "video"
}

//"youtube", "youtu" -- odtwarzacz natywny
//"gfycat", "streamable", "coub" -- odtwarzacz natywny
