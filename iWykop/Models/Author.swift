////
////  User.swift
////  iWykop
////
////  Created by Marcin Mierzejewski on 18/02/2022.
////
//
import Foundation

struct Author: AutoCodable, AutoEquatable, Hashable {
    let avatar: String
    let login: String
    let sex: AuthorSex?
    let background: String?
    let signupAt: String?
    let color: Int
    

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
    let date: String

}
