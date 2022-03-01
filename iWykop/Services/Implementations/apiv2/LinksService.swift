//
//  LinksService.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 01/03/2022.
//


import Foundation

enum LinksServiceCollections {
    case Promoted(page:Int)
    case Upcoming(page:Int)
    case Popular
    case Observed(page:Int)
    
    
    func path()->String {
        switch self {
            
        case .Promoted:
            return "Links/Promoted/"
        case .Upcoming:
            return "Links/Upcoming/"
        case .Popular:
            return "Hits/Popular/"
        case .Observed:
            return "Links/Observed/"
            
        }
    }
    
}

class LinksService : ApiV2Service {
    
    var requestedCollection = LinksServiceCollections.Upcoming(page: 1)
    
    override func getPath() -> String {
        return requestedCollection.path();
    }
    
    override func urlParams() -> [String : String]? {
        var superParams = super.urlParams()!;
        
        superParams["data"] = "full";
        switch requestedCollection {
        case .Promoted(let page):
            superParams["page"] = "\(page)";
        case .Upcoming(let page):
            superParams["page"] = "\(page)";
        case .Observed(let page):
            superParams["page"] = "\(page)";
            
        case .Popular:
            print("popular");
            
        }
        
        return superParams;
    }
    
    func getLinks() async throws -> [Link] {
        
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
