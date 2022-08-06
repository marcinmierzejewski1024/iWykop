//
//  Tag.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 15/03/2022.
//

import Foundation

typealias TagContent = [ItemInTag]
struct Tag: AutoCodable, AutoEquatable {
    var content : TagContent?;
    var meta : Meta?;

}

enum ItemInTagType : String, AutoCodable {
    case entry = "entry"
    case link = "link"
}


struct ItemInTag : AutoCodable, AutoEquatable, Hashable {

    var type : ItemInTagType;
    var link : Link?
    var entry : Entry?
    
    
    func hasAdultContent() -> Bool {
        switch type {
        case .entry:
            return entry!.hasAdultContent();
        case .link:
            return false;
        }
        
    }
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(link)
      hasher.combine(entry)
    }
    
}


