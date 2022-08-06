// Generated using Sourcery 1.8.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import Foundation
import Realm












final class TagObject: RLMEmbeddedObject {

     dynamic var content : TagContent? = nil;

     dynamic var meta : Meta? = nil;


    static func primaryKey() -> String? {
        return "id"
    }
    override init() {
    }


}






extension Tag: Persistable {

    public init(managedObject: TagObject) {

     self.content = managedObject.content;

     self.meta = managedObject.meta;



    }
    public func managedObject() -> TagObject {
        let managed = TagObject()
     managed.content = self.content;

     managed.meta = self.meta;


        return managed
    }
}
