// Generated using Sourcery 1.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
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
    guard lhs.signupAt == rhs.signupAt else { return false }
    guard lhs.color == rhs.color else { return false }
    return true
}
// MARK: - Comment AutoEquatable
extension Comment: Equatable {}
internal func == (lhs: Comment, rhs: Comment) -> Bool {
    guard lhs.author == rhs.author else { return false }
    guard lhs.status == rhs.status else { return false }
    guard lhs.id == rhs.id else { return false }
    guard lhs.voteCount == rhs.voteCount else { return false }
    guard lhs.favorite == rhs.favorite else { return false }
    guard lhs.date == rhs.date else { return false }
    guard lhs.blocked == rhs.blocked else { return false }
    guard compareOptionals(lhs: lhs.embed, rhs: rhs.embed, compare: ==) else { return false }
    guard lhs.userVote == rhs.userVote else { return false }
    guard lhs.entryID == rhs.entryID else { return false }
    guard compareOptionals(lhs: lhs.body, rhs: rhs.body, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.original, rhs: rhs.original, compare: ==) else { return false }
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
    guard lhs.favorite == rhs.favorite else { return false }
    guard lhs.userVote == rhs.userVote else { return false }
    guard lhs.blocked == rhs.blocked else { return false }
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
    return true
}

// MARK: - AutoEquatable for Enums
