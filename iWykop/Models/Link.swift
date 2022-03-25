//
//  Link.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 01/03/2022.
//

import Foundation

struct Link: AutoCodable, AutoEquatable, Hashable, BodyFormatable, WithComments {
    let id: Int
    let body: String?
    let favorite: Bool?
    var comments: [Comment]?
    let blocked: Bool?
    let author: Author
    let userVote: Int?
    let original: String?
    let embed: Embed?
    let url: String
    let date: String
    let app: String?
    let voteCount, commentsCount: Int
    let status: String?
    let canComment: Bool?
    let sourceUrl: String
    let isHot : Bool
    let buryCount: Int?
    let relatedCount: Int?
    let preview: String?
    let description: String?
    let title: String?

    
    var bodyAttributed : AttributedString?


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
        case title
        case bodyAttributed
// sourcery:end
    }
    
    
    func getSourceDomain() -> String? {
        if let url = URL(string: sourceUrl) {
            return url.host?.replacingOccurrences(of: "www.", with: "")
        }
        
        return nil;
    }
    
    func getDate() -> Date? {
        return Date.fromString(self.date)
    }
    
    func getFullPreviewImageURL() -> String? {
        let thumbnail = self.preview;
        return thumbnail?.replacingOccurrences(of: ",w104h74", with: "");
        
    }
}
