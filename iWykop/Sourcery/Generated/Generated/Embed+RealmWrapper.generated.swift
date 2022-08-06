// Generated using Sourcery 1.8.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation
import RealmSwift









final class EmbedObject: Object {

    dynamic var source : String = String();
    dynamic var plus18 : Bool = Bool();
    dynamic var preview : String = String();
    dynamic var animated : Bool = Bool();
    dynamic var ratio : Double = Double();
    dynamic var url : String = String();
    dynamic var size : String? = String();

    override static func primaryKey() -> String? {
        return "url"

    }
    override init() {
    }


}


extension Embed: Persistable {


    typealias ManagedObject = EmbedObject

    public init(managedObject: EmbedObject) {
        self.source = managedObject.source;


        self.plus18 = managedObject.plus18;


        self.preview = managedObject.preview;


        self.animated = managedObject.animated;



        self.ratio = managedObject.ratio;


        self.url = managedObject.url;


        self.size = managedObject.size;




    }
    public func managedObject() -> EmbedObject {
        let managed = EmbedObject()
    managed.source = self.source;

    managed.plus18 = self.plus18;

    managed.preview = self.preview;

    managed.animated = self.animated;


    managed.ratio = self.ratio;

    managed.url = self.url;

    managed.size = self.size;


        return managed
    }
}
