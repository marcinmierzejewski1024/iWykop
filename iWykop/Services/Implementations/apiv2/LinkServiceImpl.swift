//
//  LinkServiceImpl.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 09/03/2022.
//

import Foundation


class LinkServiceImpl : ApiV2Service, LinkService  {
    
    
    

    private var requestedId = 0;
    
    override func getPath() -> String {
        "Links/Link/\(requestedId)/withcomments/1/"
    }
    
    override func urlParams() -> [String : String]? {
        var superParams = super.urlParams()!;
        
        superParams["data"] = "full";
        return superParams;
    }
    
    func getLink(id:Int) async throws -> Link? {

        self.requestedId = id;
        let request = ApiRequest.get(url:self.getUrl(), headers: self.headers());

        let data = try await self.apiClient.httpRequestAsync(request)
        
        let resultString = String(data: data, encoding: .utf8);
        print(resultString);

        if let result = self.mapDataToEntities(Link.self, data:data) {
        
            let withAttributedBody = await bodyFormatter.addBodyAttr(es: [result.data!])
            
            return withAttributedBody.first as? Link;
        }
        
        return nil;
        
    }
    
    func getLinkVoters(id: Int) async throws -> Link? {
        self.requestedId = id;
        let request = ApiRequest.get(url:self.getUrl(), headers: self.headers());

        let data = try await self.apiClient.httpRequestAsync(request)
        
        let resultString = String(data: data, encoding: .utf8);

        if let result = self.mapDataToEntities(Link.self, data:data) {
        
            let withAttributedBody = await bodyFormatter.addBodyAttr(es: [result.data!])
            
            return withAttributedBody.first as? Link;
        }
        
        return nil;

    }
    
    
    
}
