//
//  EntryServiceImpl.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 20/02/2022.
//

import Foundation


class EntryServiceImpl : ApiV2Service, EntryService  {
    

    private var requestedId = 0;
    
    override func getPath() -> String {
        "Entries/"
    }
    
    override func urlParams() -> [String : String]? {
        var superParams = super.urlParams()!;
        
        superParams["data"] = "full";
        superParams["Entry"] = "\(requestedId)";
        
        return superParams;
    }
    
    func getEntry(id:Int) async throws -> Entry? {

        self.requestedId = id;
        let request = ApiRequest.Get(url:self.getUrl(), headers: self.headers());

        let data = try await self.apiClient.httpRequestAsync(request)
        
//        let resultString = String(data: data, encoding: .utf8);
//        print(resultString);

        if let result = self.mapDataToEntities(Entry.self, data:data) {
        
            let withAttributedBody = await bodyFormatter.addBodyAttr(es: [result])
            
            return withAttributedBody.first as? Entry;
        }
        
        return nil;
        
    }
    
}
