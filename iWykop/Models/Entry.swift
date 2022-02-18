//
//  Entry.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 18/02/2022.
//

import Foundation

struct Entry {
    
    var id: String;
    var date: Date;
    var body: String;
    var author: User;
    
    var blocked: Bool?;
    var favorite: Bool?;
    var vote_count: Int?;
    var comments_count :Int?;
}
