////
////  User.swift
////  iWykop
////
////  Created by Marcin Mierzejewski on 18/02/2022.
////
//
import Foundation
//sourcery: RealmWrapper
struct Author: AutoCodable, AutoEquatable, Hashable {
    
    var avatar: String
    var login: String
    var sex: AuthorSex?
    var background: String?
    var signupAt: Date?
    var color: Int
    

    enum CodingKeys: String, CodingKey {
        case avatar, login, sex, background
        case signupAt = "signup_at"
        case color
    }
    
    func isBanned() -> Bool {
        if(color > 1000){
            return true;
       }
        return false;
        
    }
}

enum AuthorSex : String, AutoCodable{
    case male = "male"
    case female = "female"
}


struct AuthorWithDate: AutoCodable, AutoEquatable, Hashable {
    let author: Author
    let date: Date

}
