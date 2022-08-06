// Generated using Sourcery 1.8.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation
import RealmSwift









final class AuthorObject: Object {

    dynamic var avatar : String = String();
    dynamic var login : String = String();
    dynamic var background : String? = String();
    dynamic var signupAt : Date? = Date();
    dynamic var color : Int = Int();

    override static func primaryKey() -> String? {
        return "login"

    }
    override init() {
    }


}


extension Author: Persistable {


    typealias ManagedObject = AuthorObject

    public init(managedObject: AuthorObject) {
        self.avatar = managedObject.avatar;


        self.login = managedObject.login;



        self.background = managedObject.background;


        self.signupAt = managedObject.signupAt;


        self.color = managedObject.color;




    }
    public func managedObject() -> AuthorObject {
        let managed = AuthorObject()
    managed.avatar = self.avatar;

    managed.login = self.login;


    managed.background = self.background;

    managed.signupAt = self.signupAt;

    managed.color = self.color;


        return managed
    }
}
