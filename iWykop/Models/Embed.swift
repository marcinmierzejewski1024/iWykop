////
////  Embed.swift
////  iWykop
////
////  Created by Marcin Mierzejewski on 18/02/2022.
////
//


struct Embed: AutoCodable, AutoEquatable {
    let source: String
    let plus18: Bool
    let preview: String
    let animated: Bool
    let type: String
    let ratio: Double
    let url: String
    let size: String?
}
