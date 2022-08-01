//
//  Comment.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 20/02/2022.
//

import Foundation

struct Comment: AutoCodable, AutoEquatable, Hashable, BodyFormatable {
    let author: Author
    let status: Status?
    let id: Int
    let parentID: Int?
    let voteCount: Int
    let favorite: Bool?
    let date: Date
    let blocked: Bool?
    let embed: Embed?
    let userVote: Int?
//    let app: App?
    let entryID: Int?
    let body: String?
    let original: String?
    let voteCountPlus: Int?
    let voteCountMinus: Int?

    var visibleSpoilers: [String]?
    var bodyAttributed : AttributedString?


    enum CodingKeys: String, CodingKey {
        case author, status, id
        case voteCount = "vote_count"
        case voteCountPlus = "vote_count_plus"
        case voteCountMinus = "vote_count_minus"

        case favorite, date, blocked, embed, visibleSpoilers, bodyAttributed
        case userVote = "user_vote"
        case app
        case entryID = "entry_id"
        case body, original
        case parentID = "parent_id"


    }
    

    
    func isResponseComment() -> Bool {
        
        if(self.parentID != self.id) {
            return true;
        }
        
        return false;
    }
}
