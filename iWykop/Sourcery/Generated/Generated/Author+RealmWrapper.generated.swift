// Generated using Sourcery 1.8.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import Foundation
import Realm







final class AuthorObject: RLMEmbeddedObject {

             dynamic var avatar : String = String();
             dynamic var login : String = String();
             dynamic var sex : AuthorSex? = nil;
             dynamic var background : String? = nil;
             dynamic var signupAt : Date? = nil;
             dynamic var color : Int = Int();

    static func primaryKey() -> String? {
        return "id"
    }
    override init() {
    }


}


extension Author: Persistable {

    public init(managedObject: AuthorObject) {
    self.avatar = managedObject.avatar;

    self.login = managedObject.login;

    self.sex = managedObject.sex;

    self.background = managedObject.background;

    self.signupAt = managedObject.signupAt;

    self.color = managedObject.color;



    }
    public func managedObject() -> AuthorObject {
        let managed = AuthorObject()
    managed.avatar = self.avatar;

    managed.login = self.login;

    managed.sex = self.sex;

    managed.background = self.background;

    managed.signupAt = self.signupAt;

    managed.color = self.color;


        return managed
    }
}
