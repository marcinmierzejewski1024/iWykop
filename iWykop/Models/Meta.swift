//
//  Meta.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 20/03/2022.
//

import Foundation

struct Meta: Codable,Hashable {
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
}
