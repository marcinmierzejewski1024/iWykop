//
//  EntriesService.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 18/02/2022.
//

import Foundation


class EntriesService : ApiV2Service {
    

    override func getPath() -> String {
        "Entries/Hot/"
    }
    
    override func urlParams() -> [String : String]? {
        var superParams = super.urlParams()!;
        
        superParams["data"] = "full";
        superParams["page"] = "1";
        superParams["period"] = "6";
        
        return superParams;
    }
    
    func getEntries() async throws -> [Entry] {

        let request = ApiRequest.Get(url:self.getUrl(), headers: self.headers());

        let data = try await self.apiClient.httpRequestAsync(request)
        
        let resultString = String(data: data, encoding: .utf8);
        
        return [];
    }
    
}
