//
//  User.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 18/02/2022.
//

import Foundation

enum UserSex : String {
    case male = "male"
    case female = "female"
}

struct User {
    var login :String;
    var color :Int;
    var sex :UserSex?;
    var avatar :String?;
}
