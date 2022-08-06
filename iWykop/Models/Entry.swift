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


// sourcery: AutoInit
class Entry: AutoCodable, AutoEquatable , BodyFormatable, WithComments, Hashable{
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
    var status: String?
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
    
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
    


// sourcery:inline:auto:Entry.AutoInit


    internal init(id: Int, body: String?, favorite: Bool?, userVote: Int?, blocked: Bool?, author: Author?, original: String?, embed: Embed?, url: String, date: Date, voteCount: Int, commentsCount: Int, status: String?, app: String?, comments: [Comment]?, visibleSpoilers: [String]?, bodyAttributed: AttributedString?) { // swiftlint:disable:this line_length


        self.id = id


        self.body = body


        self.favorite = favorite


        self.userVote = userVote


        self.blocked = blocked


        self.author = author


        self.original = original


        self.embed = embed


        self.url = url


        self.date = date


        self.voteCount = voteCount


        self.commentsCount = commentsCount


        self.status = status


        self.app = app


        self.comments = comments


        self.visibleSpoilers = visibleSpoilers


        self.bodyAttributed = bodyAttributed


    }
// sourcery:end
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

