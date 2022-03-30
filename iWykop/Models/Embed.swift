////
////  Embed.swift
////  iWykop
////
////  Created by Marcin Mierzejewski on 18/02/2022.
////
//
import Foundation

struct Embed: AutoCodable, AutoEquatable, Hashable {
    let source: String
    let plus18: Bool
    let preview: String
    let animated: Bool
    let type: TypeEnum
    let ratio: Double
    let url: String
    let size: String?
    
    
    func getThumbnailImageURL() -> String? {
        if(self.type == .image) {
            let thumbnail = self.url;
            return thumbnail.replacingOccurrences(of: ".jpg", with: ",w250.jpg");
        }
        
        return nil;
        
    }
    
    
    func getFullImageUrl() -> String{
        if self.animated {
            return url.replacingOccurrences(of: ".jpg", with: ".gif");//wykop apiv2 nonsense
        }
        
        return url;

    }
    
    func getSourceDomain() -> String? {
        if let url = URL(string: self.url) {
            return url.host?.replacingOccurrences(of: "www.", with: "")
        }
        
        return nil;
    }

}


enum TypeEnum: String, Codable {
    case image = "image"
    case video = "video"
}

//"youtube", "youtu" -- odtwarzacz natywny
//"gfycat", "streamable", "coub" -- odtwarzacz natywny
