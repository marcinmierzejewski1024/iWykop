//
//  EntriesServiceImpl.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 18/02/2022.
//

import Foundation


class EntriesServiceImpl : ApiV2Service, EntriesService  {
    

    
    private var requestedPeriod = EntriesPeriod.from6;
    private var requestedPage = 0;
    
    override func getPath() -> String {
        "Entries/Hot/"
    }
    
    override func urlParams() -> [String : String]? {
        var superParams = super.urlParams()!;
        
        superParams["data"] = "full";
        superParams["page"] = "\(requestedPage)";
        superParams["period"] = "\(requestedPeriod.rawValue)";
        
        return superParams;
    }
    
    func getEntries(page:Int, period:EntriesPeriod) async throws -> [Entry] {

        self.requestedPeriod = period;
        self.requestedPage = page;
        let request = ApiRequest.Get(url:self.getUrl(), headers: self.headers());

        let data = try await self.apiClient.httpRequestAsync(request, progress: nil)
        
//        let resultString = String(data: data, encoding: .utf8);
//        print(resultString);
        
        if let result = self.mapDataToEntities([Entry].self, data:data) {


            return result.data ?? [];
        } else {
            return [];
        }
    }
    
}
