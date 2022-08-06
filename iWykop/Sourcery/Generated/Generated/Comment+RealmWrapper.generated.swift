// Generated using Sourcery 1.8.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import Foundation
import Realm







final class CommentObject: RLMEmbeddedObject {

             dynamic var author : Author? = nil;
             dynamic var status : Status? = nil;
             dynamic var id : Int = Int();
             dynamic var parentID : Int? = nil;
             dynamic var voteCount : Int = Int();
             dynamic var favorite : Bool? = nil;
             dynamic var date : Date = Date();
             dynamic var blocked : Bool? = nil;
             dynamic var embed : Embed? = nil;
             dynamic var userVote : Int? = nil;
             dynamic var entryID : Int? = nil;
             dynamic var body : String? = nil;
             dynamic var original : String? = nil;
             dynamic var voteCountPlus : Int? = nil;
             dynamic var voteCountMinus : Int? = nil;

    static func primaryKey() -> String? {
        return "id"
    }
    override init() {
    }


}


extension Comment: Persistable {

    public init(managedObject: CommentObject) {
    self.author = managedObject.author;

    self.status = managedObject.status;

    self.id = managedObject.id;

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
    managed.author = self.author;

    managed.status = self.status;

    managed.id = self.id;

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
