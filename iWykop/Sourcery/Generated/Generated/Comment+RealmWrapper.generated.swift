// Generated using Sourcery 1.8.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation
import RealmSwift









final class CommentObject: Object {

    dynamic var id : Int = Int();
    dynamic var author : Author? = Author();
    dynamic var status : String = String();
    dynamic var parentID : Int? = Int();
    dynamic var voteCount : Int = Int();
    dynamic var favorite : Bool? = Bool();
    dynamic var date : Date = Date();
    dynamic var blocked : Bool? = Bool();
    dynamic var embed : Embed? = Embed();
    dynamic var userVote : Int? = Int();
    dynamic var entryID : Int? = Int();
    dynamic var body : String? = String();
    dynamic var original : String? = String();
    dynamic var voteCountPlus : Int? = Int();
    dynamic var voteCountMinus : Int? = Int();

    override static func primaryKey() -> String? {
        return "id"

    }
    override init() {
    }


}


extension Comment: Persistable {


    typealias ManagedObject = CommentObject

    public init(managedObject: CommentObject) {
        self.id = managedObject.id;


        self.author = managedObject.author;


        self.status = managedObject.status;


        self.parentID = managedObject.parentID;


        self.voteCount = managedObject.voteCount;


        self.favorite = managedObject.favorite;


        self.date = managedObject.date;


        self.blocked = managedObject.blocked;


        self.embed = managedObject.embed;


        self.userVote = managedObject.userVote;


        self.entryID = managedObject.entryID;


        self.body = managedObject.body;


        self.original = managedObject.original;


        self.voteCountPlus = managedObject.voteCountPlus;


        self.voteCountMinus = managedObject.voteCountMinus;






    }
    public func managedObject() -> CommentObject {
        let managed = CommentObject()
    managed.id = self.id;

    managed.author = self.author;

    managed.status = self.status;

    managed.parentID = self.parentID;

    managed.voteCount = self.voteCount;

    managed.favorite = self.favorite;

    managed.date = self.date;

    managed.blocked = self.blocked;

    managed.embed = self.embed;

    managed.userVote = self.userVote;

    managed.entryID = self.entryID;

    managed.body = self.body;

    managed.original = self.original;

    managed.voteCountPlus = self.voteCountPlus;

    managed.voteCountMinus = self.voteCountMinus;




        return managed
    }
}
