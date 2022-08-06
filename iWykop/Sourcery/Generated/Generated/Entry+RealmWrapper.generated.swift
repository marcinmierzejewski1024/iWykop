// Generated using Sourcery 1.8.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation
import RealmSwift









final class EntryObject: Object {

    dynamic var id : Int = Int();
    dynamic var body : String? = String();
    dynamic var favorite : Bool? = Bool();
    dynamic var userVote : Int? = Int();
    dynamic var blocked : Bool? = Bool();
    dynamic var author : Author? = Author();
    dynamic var original : String? = String();
    dynamic var embed : Embed? = Embed();
    dynamic var url : String = String();
    dynamic var date : Date = Date();
    dynamic var voteCount : Int = Int();
    dynamic var commentsCount : Int = Int();
    dynamic var status : String = String();
    dynamic var app : String? = String();
    dynamic var comments : [Comment]? = [Comment]();

    override static func primaryKey() -> String? {
        return "id"

    }
    override init() {
    }


}


extension Entry: Persistable {


    typealias ManagedObject = EntryObject

    public init(managedObject: EntryObject) {
        self.id = managedObject.id;


        self.body = managedObject.body;


        self.favorite = managedObject.favorite;


        self.userVote = managedObject.userVote;


        self.blocked = managedObject.blocked;


        self.author = managedObject.author;


        self.original = managedObject.original;


        self.embed = managedObject.embed;


        self.url = managedObject.url;


        self.date = managedObject.date;


        self.voteCount = managedObject.voteCount;


        self.commentsCount = managedObject.commentsCount;


        self.status = managedObject.status;


        self.app = managedObject.app;


        self.comments = managedObject.comments;






    }
    public func managedObject() -> EntryObject {
        let managed = EntryObject()
    managed.id = self.id;

    managed.body = self.body;

    managed.favorite = self.favorite;

    managed.userVote = self.userVote;

    managed.blocked = self.blocked;

    managed.author = self.author;

    managed.original = self.original;

    managed.embed = self.embed;

    managed.url = self.url;

    managed.date = self.date;

    managed.voteCount = self.voteCount;

    managed.commentsCount = self.commentsCount;

    managed.status = self.status;

    managed.app = self.app;

    managed.comments = self.comments;




        return managed
    }
}
