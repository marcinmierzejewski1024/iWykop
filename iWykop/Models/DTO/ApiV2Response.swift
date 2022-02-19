//
//  ApiV2Response.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 19/02/2022.
//

import Foundation

struct ApiV2Error: AutoCodable {
    let code: Int
    let messageEn: String
    var field = ""
    let messagePl: String
    
    enum CodingKeys: String, CodingKey {
        case code
        case messageEn
        case field
        case messagePl
    }
    
    func throwPl() throws {
        throw messagePl;
    }
}


struct ApiV2Response<T : Codable> : AutoCodable {
        var error: ApiV2Error?
        var data: T?;
    
    
}
