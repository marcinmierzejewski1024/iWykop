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
}

enum LinksServiceCollections : String {
    case Promoted = "Links/Promoted/"
    case Upcoming = "Links/Upcoming/"
    case Popular = "Hits/Popular/"
    case Observed = "Links/Observed/"
    
    
}


protocol LinksService {
    func getLinks(collection:LinksServiceCollections, page : Int) async throws -> [Link];

}

protocol EntriesService {
    func getEntries(page:Int, period:EntriesPeriod) async throws -> [Entry];
}

protocol EntryService {
    func getEntry(id:Int) async throws -> Entry?;
}
