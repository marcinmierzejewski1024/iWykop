// Generated using Sourcery 1.8.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import UIKit




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



extension ItemInTagType {

    enum CodingKeys: String, CodingKey {
        case entry
        case link
    }

    internal init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        let enumCase = try container.decode(String.self)
        switch enumCase {
        case CodingKeys.entry.rawValue: self = .entry
        case CodingKeys.link.rawValue: self = .link
        default: throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Unknown enum case '\(enumCase)'"))
        }
    }

    internal func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        switch self {
        case .entry: try container.encode(CodingKeys.entry.rawValue)
        case .link: try container.encode(CodingKeys.link.rawValue)
        }
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

