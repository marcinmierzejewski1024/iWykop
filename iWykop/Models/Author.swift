////
////  User.swift
////  iWykop
////
////  Created by Marcin Mierzejewski on 18/02/2022.
////
//
import Foundation
// sourcery: AutoInit
class Author: AutoCodable, AutoEquatable, Hashable {
    
    var avatar: String = ""
    // sourcery: primaryKey
    var login: String = ""
    // sourcery: skipPersistance
    var sex: AuthorSex?
    var background: String?
    var signupAt: Date?
    var color: Int = 0;
    

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
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(login)
    }



// sourcery:inline:auto:Author.AutoInit


    internal init(avatar: String, login: String, sex: AuthorSex?, background: String?, signupAt: Date?, color: Int) { // swiftlint:disable:this line_length


        self.avatar = avatar


        self.login = login


        self.sex = sex


        self.background = background


        self.signupAt = signupAt


        self.color = color


    }
// sourcery:end
}

enum AuthorSex : String, AutoCodable{
    case male = "male"
    case female = "female"
}


struct AuthorWithDate: AutoCodable, AutoEquatable, Hashable {
    let author: Author
    let date: Date
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(author)
      hasher.combine(date)
    }

}
