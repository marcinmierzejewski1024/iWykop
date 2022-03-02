//
//  LinksService.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 01/03/2022.
//


import Foundation

enum LinksServiceCollections : String {
    case Promoted = "Links/Promoted/"
    case Upcoming = "Links/Upcoming/"
    case Popular = "Hits/Popular/"
    case Observed = "Links/Observed/"
    
    
}

class LinksService : ApiV2Service {
    
    var requestedCollection = LinksServiceCollections.Upcoming
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
        
        let resultString = String(data: data, encoding: .utf8);
        print(resultString);
        
        if let result = self.mapDataToEntities([Link].self, data:data) {
            
            return result;
        } else {
            return [];
        }
    }
    
}
