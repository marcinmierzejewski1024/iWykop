// Generated using Sourcery 1.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all


// MARK: - AutoHashable for classes, protocols, structs
// MARK: - Author AutoHashable
extension Author: Hashable {
    internal func hash(into hasher: inout Hasher) {
        avatar.hash(into: &hasher)
        login.hash(into: &hasher)
        sex.hash(into: &hasher)
        background.hash(into: &hasher)
        signupAt.hash(into: &hasher)
        color.hash(into: &hasher)
    }
}
// MARK: - Embed AutoHashable
extension Embed: Hashable {
    internal func hash(into hasher: inout Hasher) {
        source.hash(into: &hasher)
        plus18.hash(into: &hasher)
        preview.hash(into: &hasher)
        animated.hash(into: &hasher)
        type.hash(into: &hasher)
        ratio.hash(into: &hasher)
        url.hash(into: &hasher)
        size.hash(into: &hasher)
    }
}
// MARK: - Entry AutoHashable
extension Entry: Hashable {
    internal func hash(into hasher: inout Hasher) {
        id.hash(into: &hasher)
        body.hash(into: &hasher)
        favorite.hash(into: &hasher)
        userVote.hash(into: &hasher)
        blocked.hash(into: &hasher)
        author.hash(into: &hasher)
        original.hash(into: &hasher)
        embed.hash(into: &hasher)
        url.hash(into: &hasher)
        date.hash(into: &hasher)
        voteCount.hash(into: &hasher)
        commentsCount.hash(into: &hasher)
        status.hash(into: &hasher)
        app.hash(into: &hasher)
    }
}

// MARK: - AutoHashable for Enums
