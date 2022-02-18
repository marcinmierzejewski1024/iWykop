//
//  String.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 17/02/2022.
//

import Foundation
import CryptoKit


extension String: LocalizedError {
    public var errorDescription: String? { return self }
}


func MD5(string: String) -> String {
    let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())

    return digest.map {
        String(format: "%02hhx", $0)
    }.joined()
}

