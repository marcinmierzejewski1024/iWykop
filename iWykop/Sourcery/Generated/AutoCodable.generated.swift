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




extension Status {

    enum CodingKeys: String, CodingKey {
        case visible
    }

    internal init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        let enumCase = try container.decode(String.self)
        switch enumCase {
        case CodingKeys.visible.rawValue: self = .visible
        default: throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Unknown enum case '\(enumCase)'"))
        }
    }

    internal func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        switch self {
        case .visible: try container.encode(CodingKeys.visible.rawValue)
        }
    }

}
