// Generated using Sourcery 1.8.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import Foundation
import Realm







final class LinkObject: RLMEmbeddedObject {

             dynamic var id : Int = Int();
             dynamic var body : String? = nil;
             dynamic var favorite : Bool? = nil;
             dynamic var comments : [Comment]? = nil;
             dynamic var blocked : Bool? = nil;
             dynamic var author : Author? = nil;
             dynamic var userVote : Int? = nil;
             dynamic var original : String? = nil;
             dynamic var embed : Embed? = nil;
             dynamic var url : String = String();
             dynamic var date : Date = Date();
             dynamic var app : String? = nil;
             dynamic var voteCount : Int = Int();
             dynamic var commentsCount : Int = Int();
             dynamic var status : String? = nil;
             dynamic var canComment : Bool? = nil;
             dynamic var sourceUrl : String = String();
             dynamic var isHot : Bool = Bool();
             dynamic var buryCount : Int? = nil;
             dynamic var relatedCount : Int? = nil;
             dynamic var preview : String? = nil;
             dynamic var title : String? = nil;
             dynamic var tags : String? = nil;

    static func primaryKey() -> String? {
        return "id"
    }
    override init() {
    }


}


extension Link: Persistable {

    public init(managedObject: LinkObject) {
    self.id = managedObject.id;

    self.body = managedObject.body;

    self.favorite = managedObject.favorite;

    self.comments = managedObject.comments;

    self.blocked = managedObject.blocked;

    self.author = managedObject.author;

    self.userVote = managedObject.userVote;

    self.original = managedObject.original;

    self.embed = managedObject.embed;

    self.url = managedObject.url;

    self.date = managedObject.date;

    self.app = managedObject.app;

    self.voteCount = managedObject.voteCount;

    self.commentsCount = managedObject.commentsCount;

    self.status = managedObject.status;

    self.canComment = managedObject.canComment;

    self.sourceUrl = managedObject.sourceUrl;

    self.isHot = managedObject.isHot;

    self.buryCount = managedObject.buryCount;

    self.relatedCount = managedObject.relatedCount;

    self.preview = managedObject.preview;


    self.title = managedObject.title;

    self.tags = managedObject.tags;





    }
    public func managedObject() -> LinkObject {
        let managed = LinkObject()
    managed.id = self.id;

    managed.body = self.body;

    managed.favorite = self.favorite;

    managed.comments = self.comments;

    managed.blocked = self.blocked;

    managed.author = self.author;

    managed.userVote = self.userVote;

    managed.original = self.original;

    managed.embed = self.embed;

    managed.url = self.url;

    managed.date = self.date;

    managed.app = self.app;

    managed.voteCount = self.voteCount;

    managed.commentsCount = self.commentsCount;

    managed.status = self.status;

    managed.canComment = self.canComment;

    managed.sourceUrl = self.sourceUrl;

    managed.isHot = self.isHot;

    managed.buryCount = self.buryCount;

    managed.relatedCount = self.relatedCount;

    managed.preview = self.preview;


    managed.title = self.title;

    managed.tags = self.tags;




        return managed
    }
}
