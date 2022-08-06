// Generated using Sourcery 1.8.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation
import RealmSwift









final class LinkObject: Object {

    dynamic var id : Int = Int();
    dynamic var body : String? = String();
    dynamic var favorite : Bool? = Bool();
    dynamic var comments : [Comment]? = [Comment]();
    dynamic var blocked : Bool? = Bool();
    dynamic var author : Author? = Author();
    dynamic var userVote : Int? = Int();
    dynamic var original : String? = String();
    dynamic var embed : Embed? = Embed();
    dynamic var url : String = String();
    dynamic var date : Date = Date();
    dynamic var app : String? = String();
    dynamic var voteCount : Int = Int();
    dynamic var commentsCount : Int = Int();
    dynamic var status : String? = String();
    dynamic var canComment : Bool? = Bool();
    dynamic var sourceUrl : String = String();
    dynamic var isHot : Bool = Bool();
    dynamic var buryCount : Int? = Int();
    dynamic var relatedCount : Int? = Int();
    dynamic var preview : String? = String();
    dynamic var title : String? = String();
    dynamic var tags : String? = String();

    override static func primaryKey() -> String? {
        return "id"

    }
    override init() {
    }


}


extension Link: Persistable {


    typealias ManagedObject = LinkObject

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
