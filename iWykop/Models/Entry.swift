//
//  Entry.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 18/02/2022.
//

import Foundation

protocol AutoDecodable: Decodable {}
protocol AutoEncodable: Encodable {}
protocol AutoCodable: AutoDecodable, AutoEncodable {}

protocol AutoEquatable {
    
}



//sourcery: RealmWrapper
struct Entry: AutoCodable, AutoEquatable, Hashable , BodyFormatable, WithComments{
    // sourcery: primaryKey
    var id: Int = 0;
    var body: String?
    var favorite: Bool?
    var userVote: Int?
    var blocked: Bool?
    var author: Author?
    var original: String?
    var embed: Embed?
    var url: String = ""
    var date: Date = Date()
    var voteCount: Int = 0;
    var commentsCount: Int = 0;
    var status: String
    var app: String?
    var comments: [Comment]?
    // sourcery: skipPersistance
    var visibleSpoilers: [String]?
    // sourcery: skipPersistance
    var bodyAttributed : AttributedString?

    enum CodingKeys: String, CodingKey {
        case id, body, favorite
        case userVote = "user_vote"
        case blocked, author, original, embed, url, date
        case voteCount = "vote_count"
        case commentsCount = "comments_count"
        case status, app
        case comments

// sourcery:inline:auto:Entry.CodingKeys.AutoCodable
        case visibleSpoilers
        case bodyAttributed
// sourcery:end
    }
    
    
    func hasAdultContent() -> Bool {
        if let embed = embed {
            return embed.plus18;
        }
        
        return false;
    }
    
    
}



enum Status: String, AutoCodable {
    case visible = "visible"
    case `public` = "public"
    case deleted = "deleted"
    case promoted = "promoted"


}

struct Pagination: AutoCodable {
    let next: String
}

