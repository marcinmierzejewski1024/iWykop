// Generated using Sourcery 1.8.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import UIKit

// swiftlint:disable file_length
fileprivate func compareOptionals<T>(lhs: T?, rhs: T?, compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    switch (lhs, rhs) {
    case let (lValue?, rValue?):
        return compare(lValue, rValue)
    case (nil, nil):
        return true
    default:
        return false
    }
}

fileprivate func compareArrays<T>(lhs: [T], rhs: [T], compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (idx, lhsItem) in lhs.enumerated() {
        guard compare(lhsItem, rhs[idx]) else { return false }
    }

    return true
}


// MARK: - AutoEquatable for classes, protocols, structs
// MARK: - Author AutoEquatable
extension Author: Equatable {}
internal func == (lhs: Author, rhs: Author) -> Bool {
    guard lhs.avatar == rhs.avatar else { return false }
    guard lhs.login == rhs.login else { return false }
    guard compareOptionals(lhs: lhs.sex, rhs: rhs.sex, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.background, rhs: rhs.background, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.signupAt, rhs: rhs.signupAt, compare: ==) else { return false }
    guard lhs.color == rhs.color else { return false }
    return true
}
// MARK: - AuthorWithDate AutoEquatable
extension AuthorWithDate: Equatable {}
internal func == (lhs: AuthorWithDate, rhs: AuthorWithDate) -> Bool {
    guard lhs.author == rhs.author else { return false }
    guard lhs.date == rhs.date else { return false }
    return true
}
// MARK: - Comment AutoEquatable
extension Comment: Equatable {}
internal func == (lhs: Comment, rhs: Comment) -> Bool {
    guard lhs.author == rhs.author else { return false }
    guard compareOptionals(lhs: lhs.status, rhs: rhs.status, compare: ==) else { return false }
    guard lhs.id == rhs.id else { return false }
    guard compareOptionals(lhs: lhs.parentID, rhs: rhs.parentID, compare: ==) else { return false }
    guard lhs.voteCount == rhs.voteCount else { return false }
    guard compareOptionals(lhs: lhs.favorite, rhs: rhs.favorite, compare: ==) else { return false }
    guard lhs.date == rhs.date else { return false }
    guard compareOptionals(lhs: lhs.blocked, rhs: rhs.blocked, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.embed, rhs: rhs.embed, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.userVote, rhs: rhs.userVote, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.entryID, rhs: rhs.entryID, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.body, rhs: rhs.body, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.original, rhs: rhs.original, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.voteCountPlus, rhs: rhs.voteCountPlus, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.voteCountMinus, rhs: rhs.voteCountMinus, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.visibleSpoilers, rhs: rhs.visibleSpoilers, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.bodyAttributed, rhs: rhs.bodyAttributed, compare: ==) else { return false }
    return true
}
// MARK: - Embed AutoEquatable
extension Embed: Equatable {}
internal func == (lhs: Embed, rhs: Embed) -> Bool {
    guard lhs.source == rhs.source else { return false }
    guard lhs.plus18 == rhs.plus18 else { return false }
    guard lhs.preview == rhs.preview else { return false }
    guard lhs.animated == rhs.animated else { return false }
    guard lhs.type == rhs.type else { return false }
    guard lhs.ratio == rhs.ratio else { return false }
    guard lhs.url == rhs.url else { return false }
    guard compareOptionals(lhs: lhs.size, rhs: rhs.size, compare: ==) else { return false }
    return true
}
// MARK: - Entry AutoEquatable
extension Entry: Equatable {}
internal func == (lhs: Entry, rhs: Entry) -> Bool {
    guard lhs.id == rhs.id else { return false }
    guard compareOptionals(lhs: lhs.body, rhs: rhs.body, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.favorite, rhs: rhs.favorite, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.userVote, rhs: rhs.userVote, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.blocked, rhs: rhs.blocked, compare: ==) else { return false }
    guard lhs.author == rhs.author else { return false }
    guard compareOptionals(lhs: lhs.original, rhs: rhs.original, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.embed, rhs: rhs.embed, compare: ==) else { return false }
    guard lhs.url == rhs.url else { return false }
    guard lhs.date == rhs.date else { return false }
    guard lhs.voteCount == rhs.voteCount else { return false }
    guard lhs.commentsCount == rhs.commentsCount else { return false }
    guard lhs.status == rhs.status else { return false }
    guard compareOptionals(lhs: lhs.app, rhs: rhs.app, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.comments, rhs: rhs.comments, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.visibleSpoilers, rhs: rhs.visibleSpoilers, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.bodyAttributed, rhs: rhs.bodyAttributed, compare: ==) else { return false }
    return true
}
// MARK: - ItemInTag AutoEquatable
extension ItemInTag: Equatable {}
internal func == (lhs: ItemInTag, rhs: ItemInTag) -> Bool {
    guard lhs.type == rhs.type else { return false }
    guard compareOptionals(lhs: lhs.link, rhs: rhs.link, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.entry, rhs: rhs.entry, compare: ==) else { return false }
    return true
}
// MARK: - Link AutoEquatable
extension Link: Equatable {}
internal func == (lhs: Link, rhs: Link) -> Bool {
    guard lhs.id == rhs.id else { return false }
    guard compareOptionals(lhs: lhs.body, rhs: rhs.body, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.favorite, rhs: rhs.favorite, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.comments, rhs: rhs.comments, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.blocked, rhs: rhs.blocked, compare: ==) else { return false }
    guard lhs.author == rhs.author else { return false }
    guard compareOptionals(lhs: lhs.userVote, rhs: rhs.userVote, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.original, rhs: rhs.original, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.embed, rhs: rhs.embed, compare: ==) else { return false }
    guard lhs.url == rhs.url else { return false }
    guard lhs.date == rhs.date else { return false }
    guard compareOptionals(lhs: lhs.app, rhs: rhs.app, compare: ==) else { return false }
    guard lhs.voteCount == rhs.voteCount else { return false }
    guard lhs.commentsCount == rhs.commentsCount else { return false }
    guard compareOptionals(lhs: lhs.status, rhs: rhs.status, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.canComment, rhs: rhs.canComment, compare: ==) else { return false }
    guard lhs.sourceUrl == rhs.sourceUrl else { return false }
    guard lhs.isHot == rhs.isHot else { return false }
    guard compareOptionals(lhs: lhs.buryCount, rhs: rhs.buryCount, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.relatedCount, rhs: rhs.relatedCount, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.preview, rhs: rhs.preview, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.description, rhs: rhs.description, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.title, rhs: rhs.title, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.tags, rhs: rhs.tags, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.bodyAttributed, rhs: rhs.bodyAttributed, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.visibleSpoilers, rhs: rhs.visibleSpoilers, compare: ==) else { return false }
    return true
}
// MARK: - Tag AutoEquatable
extension Tag: Equatable {}
internal func == (lhs: Tag, rhs: Tag) -> Bool {
    guard compareOptionals(lhs: lhs.content, rhs: rhs.content, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.meta, rhs: rhs.meta, compare: ==) else { return false }
    return true
}

// MARK: - AutoEquatable for Enums
