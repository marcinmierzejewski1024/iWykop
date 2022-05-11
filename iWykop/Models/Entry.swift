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




struct Entry: AutoCodable, AutoEquatable, Hashable , BodyFormatable, WithComments{
    let id: Int
    let body: String?
    let favorite: Bool?
    let userVote: Int?
    let blocked: Bool?
    let author: Author
    let original: String?
    let embed: Embed?
    let url: String
    let date: String
    let voteCount, commentsCount: Int
    let status: Status
    let app: String?
    var comments: [Comment]?
    var visibleSpoilers: [String]?
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
    
    func getDate() -> Date? {
        return Date.fromString(self.date)
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

