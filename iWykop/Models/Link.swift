//
//  Link.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 01/03/2022.
//

import Foundation

//sourcery: RealmWrapper
struct Link: AutoCodable, AutoEquatable, Hashable, BodyFormatable, WithComments {
    var id: Int
    var body: String?
    var favorite: Bool?
    var comments: [Comment]?
    var blocked: Bool?
    var author: Author?
    var userVote: Int?
    var original: String?
    var embed: Embed?
    var url: String
    var date: Date
    var app: String?
    var voteCount: Int
    var commentsCount: Int
    var status: String?
    var canComment: Bool?
    var sourceUrl: String
    var isHot : Bool
    var buryCount: Int?
    var relatedCount: Int?
    var preview: String?
    
    // sourcery: skipPersistance
    var description: String?//TODO:
    var title: String?
    var tags: String?
    
    // sourcery: skipPersistance
    var bodyAttributed : AttributedString?
    // sourcery: skipPersistance
    var visibleSpoilers: [String]?



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
        case tags

// sourcery:inline:auto:Link.CodingKeys.AutoCodable
        case favorite
        case title
        case bodyAttributed
        case visibleSpoilers
// sourcery:end
    }
    
    
    func getSourceDomain() -> String? {
        if let url = URL(string: sourceUrl) {
            return url.host?.replacingOccurrences(of: "www.", with: "")
        }
        
        return nil;
    }
    

    
    func getFullPreviewImageURL() -> String? {
        let thumbnail = self.preview;
        return thumbnail?.replacingOccurrences(of: ",w104h74", with: "");
        
    }
    
    func getTagsList() -> [String]? {
        if let tags = tags {
            return tags.components(separatedBy: " ");
        }
        
        return nil;
    }
}
