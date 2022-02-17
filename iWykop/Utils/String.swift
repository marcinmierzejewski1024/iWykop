//
//  String.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 17/02/2022.
//

import Foundation


extension String: LocalizedError {
    public var errorDescription: String? { return self }
}
