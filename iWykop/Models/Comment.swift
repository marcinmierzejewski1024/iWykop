//
//  Comment.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 20/02/2022.
//

import Foundation

// sourcery: AutoInit
class Comment: AutoCodable, AutoEquatable, BodyFormatable {
    // sourcery: primaryKey
    var id: Int = 0;
    var author: Author?
    var status: String?
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



// sourcery:inline:auto:Comment.AutoInit


    internal init(id: Int, author: Author?, status: String?, parentID: Int?, voteCount: Int, favorite: Bool?, date: Date, blocked: Bool?, embed: Embed?, userVote: Int?, entryID: Int?, body: String?, original: String?, voteCountPlus: Int?, voteCountMinus: Int?, visibleSpoilers: [String]?, bodyAttributed: AttributedString?) { // swiftlint:disable:this line_length


        self.id = id


        self.author = author


        self.status = status


        self.parentID = parentID


        self.voteCount = voteCount


        self.favorite = favorite


        self.date = date


        self.blocked = blocked


        self.embed = embed


        self.userVote = userVote


        self.entryID = entryID


        self.body = body


        self.original = original


        self.voteCountPlus = voteCountPlus


        self.voteCountMinus = voteCountMinus


        self.visibleSpoilers = visibleSpoilers


        self.bodyAttributed = bodyAttributed


    }
// sourcery:end
}
