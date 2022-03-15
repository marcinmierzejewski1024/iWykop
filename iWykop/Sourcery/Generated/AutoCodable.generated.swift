// Generated using Sourcery 1.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT




extension AuthorSex {

    enum CodingKeys: String, CodingKey {
        case male
        case female
    }

    internal init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        let enumCase = try container.decode(String.self)
        switch enumCase {
        case CodingKeys.male.rawValue: self = .male
        case CodingKeys.female.rawValue: self = .female
        default: throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Unknown enum case '\(enumCase)'"))
        }
    }

    internal func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        switch self {
        case .male: try container.encode(CodingKeys.male.rawValue)
        case .female: try container.encode(CodingKeys.female.rawValue)
        }
    }

}

extension Comment {

    internal init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        author = try container.decode(Author.self, forKey: .author)
        status = try container.decodeIfPresent(Status.self, forKey: .status)
        id = try container.decode(Int.self, forKey: .id)
        voteCount = try container.decode(Int.self, forKey: .voteCount)
        favorite = try container.decodeIfPresent(Bool.self, forKey: .favorite)
        date = try container.decode(String.self, forKey: .date)
        blocked = try container.decodeIfPresent(Bool.self, forKey: .blocked)
        embed = try container.decodeIfPresent(Embed.self, forKey: .embed)
        userVote = try container.decodeIfPresent(Int.self, forKey: .userVote)
        entryID = try container.decodeIfPresent(Int.self, forKey: .entryID)
        body = try container.decodeIfPresent(String.self, forKey: .body)
        original = try container.decodeIfPresent(String.self, forKey: .original)
    }

    internal func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(author, forKey: .author)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encode(id, forKey: .id)
        try container.encode(voteCount, forKey: .voteCount)
        try container.encodeIfPresent(favorite, forKey: .favorite)
        try container.encode(date, forKey: .date)
        try container.encodeIfPresent(blocked, forKey: .blocked)
        try container.encodeIfPresent(embed, forKey: .embed)
        try container.encodeIfPresent(userVote, forKey: .userVote)
        try container.encodeIfPresent(entryID, forKey: .entryID)
        try container.encodeIfPresent(body, forKey: .body)
        try container.encodeIfPresent(original, forKey: .original)
    }

}





extension Status {

    enum CodingKeys: String, CodingKey {
        case visible
        case `public`
        case deleted
        case promoted
    }

    internal init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        let enumCase = try container.decode(String.self)
        switch enumCase {
        case CodingKeys.visible.rawValue: self = .visible
        case CodingKeys.`public`.rawValue: self = .`public`
        case CodingKeys.deleted.rawValue: self = .deleted
        case CodingKeys.promoted.rawValue: self = .promoted
        default: throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Unknown enum case '\(enumCase)'"))
        }
    }

    internal func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        switch self {
        case .visible: try container.encode(CodingKeys.visible.rawValue)
        case .`public`: try container.encode(CodingKeys.`public`.rawValue)
        case .deleted: try container.encode(CodingKeys.deleted.rawValue)
        case .promoted: try container.encode(CodingKeys.promoted.rawValue)
        }
    }

}

