//
//  Meta.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 20/03/2022.
//

import Foundation

// sourcery: AutoInit
class Meta: Codable,AutoEquatable {
    let isOwn: Bool
    let isObserved: Bool
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



// sourcery:inline:auto:Meta.AutoInit


    internal init(isOwn: Bool, isObserved: Bool, owner: String?, isBlocked: Bool?, tag: String, description: String?, background: String?) { // swiftlint:disable:this line_length


        self.isOwn = isOwn


        self.isObserved = isObserved


        self.owner = owner


        self.isBlocked = isBlocked


        self.tag = tag


        self.description = description


        self.background = background


    }
// sourcery:end
}
