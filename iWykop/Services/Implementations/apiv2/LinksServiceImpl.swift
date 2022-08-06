//
//  LinksServiceImpl.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 01/03/2022.
//


import Foundation
import RealmSwift


class LinksServiceImpl : ApiV2Service, LinksService {
    

    var requestedCollection = LinksServiceCollections.Promoted
    var requestedPage = 1;
    
    override func getPath() -> String {
        return requestedCollection.rawValue;
    }
    
    override func urlParams() -> [String : String]? {
        var superParams = super.urlParams()!;
        
        superParams["data"] = "full";
        switch requestedCollection {
        case .Promoted:
            superParams["page"] = "\(requestedPage)";
        case .Upcoming:
            superParams["page"] = "\(requestedPage)";
        case .Observed:
            superParams["page"] = "\(requestedPage)";
            
        case .Popular:
            print("popular");
            
        }
        
        return superParams;
    }
    
    func getLinks(collection:LinksServiceCollections, page : Int = 1) async throws -> [Link] {
        
        self.requestedPage = page;
        self.requestedCollection = collection;
        let request = ApiRequest.Get(url:self.getUrl(), headers: self.headers());
        
        let data = try await self.apiClient.httpRequestAsync(request)
        
//        let resultString = String(data: data, encoding: .utf8);
//        print(resultString);
        
        if let result = self.mapDataToEntities([Link].self, data:data) {
            
            
            let withAttributedBody = await bodyFormatter.addBodyAttr(es: result.data ?? [])
            
//            let realm = try! Realm()
//            realm.
            // Create a dog in the realm.
//            try! realm.write {
//                realm.add(result.data?.first)
//            }

            
            return withAttributedBody as? [Link] ?? [];
        } else {
            return [];
        }
    }
    
}
