//
//  Comment.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 20/02/2022.
//

import Foundation

//sourcery: RealmWrapper
struct Comment: AutoCodable, AutoEquatable, Hashable, BodyFormatable {
    // sourcery: primaryKey
    var id: Int = 0;
    var author: Author?
    var status: String
    var parentID: Int?
    var voteCount: Int = 0;
    var favorite: Bool?
    var date: Date = Date()
    var blocked: Bool?
    var embed: Embed?
    var userVote: Int?
    var entryID: Int?
    var body: String?
    var original: String?
    var voteCountPlus: Int?
    var voteCountMinus: Int?

    // sourcery: skipPersistance
    var visibleSpoilers: [String]?
    // sourcery: skipPersistance
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
