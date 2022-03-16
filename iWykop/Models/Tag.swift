//
//  Tag.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 15/03/2022.
//

import Foundation


struct Tag: AutoCodable, AutoEquatable, Hashable {
    let meta: Meta?;
    
}


struct Meta: Codable,Hashable {
    let isOwn, isObserved: Bool
    let owner: String?
    let isBlocked: Bool?
    let tag: String
    let description: String?
    let background: String?

    enum CodingKeys: String, CodingKey {
        case isOwn = "is_own"
        case isObserved = "is_observed"
        case owner
        case isBlocked = "is_blocked"
        case tag
        case description = "description"
        case background
    }
}
