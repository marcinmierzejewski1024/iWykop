//
//  Link.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 01/03/2022.
//

import Foundation

struct Link: AutoCodable, AutoEquatable, Hashable {
    let id: Int
    let body: String?
    let favorite: Bool?
    let comments: [Comment]?
    let blocked: Bool?
    let author: Author
    let userVote: Int?
    let original: String?
    let embed: Embed?
    let url: String
    let date: String
    let app: String?
    let voteCount, commentsCount: Int
    let status: String
    let canComment: Bool?
    let sourceUrl: String
    let isHot : Bool
    let buryCount: Int?
    let relatedCount: Int?
    let preview: String?
    let description: String?


    enum CodingKeys: String, CodingKey {
        case id, body, comments, blocked, author
        case userVote = "user_vote"
        case original, embed, url, date, app
        case voteCount = "vote_count"
        case commentsCount = "comments_count"
        case status
        case canComment = "can_comment"
        case sourceUrl = "source_url"
        case buryCount = "bury_count"
        case relatedCount = "related_count"
        case isHot = "is_hot"
        case preview
        case description

// sourcery:inline:auto:Link.CodingKeys.AutoCodable
        case favorite
// sourcery:end
    }
    
    
    func getSourceDomain() -> String? {
        if let url = URL(string: sourceUrl) {
            return url.host?.replacingOccurrences(of: "www.", with: "")
        }
        
        return nil;
    }
}
