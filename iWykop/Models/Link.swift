//
//  Link.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 01/03/2022.
//

import Foundation

// sourcery: AutoInit
class Link: AutoCodable, AutoEquatable, BodyFormatable, WithComments, Hashable {
    // sourcery: primaryKey
    var id: Int = 0;
    var body: String?
    var favorite: Bool?
    var comments: [Comment]?
    var blocked: Bool?
    var author: Author?
    var userVote: Int?
    var original: String?
    var embed: Embed?
    var url: String = ""
    var date: Date = Date()
    var app: String?
    var voteCount: Int = 0;
    var commentsCount: Int = 0;
    var status: String?
    var canComment: Bool?
    var sourceUrl: String = ""
    var isHot : Bool = false
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
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
      hasher.combine(body)
    }



// sourcery:inline:auto:Link.AutoInit


    internal init(id: Int, body: String?, favorite: Bool?, comments: [Comment]?, blocked: Bool?, author: Author?, userVote: Int?, original: String?, embed: Embed?, url: String, date: Date, app: String?, voteCount: Int, commentsCount: Int, status: String?, canComment: Bool?, sourceUrl: String, isHot: Bool, buryCount: Int?, relatedCount: Int?, preview: String?, description: String?, title: String?, tags: String?, bodyAttributed: AttributedString?, visibleSpoilers: [String]?) { // swiftlint:disable:this line_length


        self.id = id


        self.body = body


        self.favorite = favorite


        self.comments = comments


        self.blocked = blocked


        self.author = author


        self.userVote = userVote


        self.original = original


        self.embed = embed


        self.url = url


        self.date = date


        self.app = app


        self.voteCount = voteCount


        self.commentsCount = commentsCount


        self.status = status


        self.canComment = canComment


        self.sourceUrl = sourceUrl


        self.isHot = isHot


        self.buryCount = buryCount


        self.relatedCount = relatedCount


        self.preview = preview


        self.description = description


        self.title = title


        self.tags = tags


        self.bodyAttributed = bodyAttributed


        self.visibleSpoilers = visibleSpoilers


    }
// sourcery:end
}
