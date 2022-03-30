////
////  Embed.swift
////  iWykop
////
////  Created by Marcin Mierzejewski on 18/02/2022.
////
//


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
    
    func isGif() -> Bool {
        return self.url.hasSuffix(".gif");
    }
}


enum TypeEnum: String, Codable {
    case image = "image"
    case video = "video"
}
