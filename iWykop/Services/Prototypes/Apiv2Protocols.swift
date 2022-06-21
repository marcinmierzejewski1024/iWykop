//
//  Apiv2Protocols.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 06/03/2022.
//

import Foundation


enum EntriesPeriod : Int {
    case from6 = 6
    case from12 = 12
    case from24 = 24
    
    static func fromRaw(rawValue:Int) -> EntriesPeriod? {
        switch rawValue {
        case 6:
            return .from6
        case 12:
            return .from12
        case 24:
            return .from24
            
        default:
            return nil;
        }
    }
}

enum LinksServiceCollections : String {
    case Promoted = "Links/Promoted/"
    case Upcoming = "Links/Upcoming/"
    case Popular = "Hits/Popular/"
    case Observed = "Links/Observed/"
    
    
}
protocol AnythingViewModelProvider {
    func getViewModelFor(url:URL) async throws -> BasePushableViewModel?;
}

protocol LinksService {
    func getLinks(collection:LinksServiceCollections, page : Int) async throws -> [Link];
}

protocol LinkService {
    func getLink(id:Int) async throws -> Link?;
}

protocol VotersService {
    func getLinkVoters(id:Int, downvotes : Bool) async throws -> [AuthorWithDate];
    func getEntryVoters(id:Int) async throws -> [AuthorWithDate];

}

protocol EntriesService {
    func getEntries(page:Int, period:EntriesPeriod) async throws -> [Entry];
}

protocol EntryService {
    func getEntry(id:Int) async throws -> Entry?;
}

protocol TagService {
    func getTag(tag:String) async throws -> Tag?;
}

protocol AuthorService {
    func getAuthor(name:String) async throws -> Author?;
}
