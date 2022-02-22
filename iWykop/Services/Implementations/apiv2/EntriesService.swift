//
//  EntriesService.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 18/02/2022.
//

import Foundation


class EntriesService : ApiV2Service {
    
    enum EntriesPeriod : Int {
        case from6 = 6
        case from12 = 12
        case from24 = 24
    }
    
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
    
    func getEntries(page:Int) async throws -> [Entry] {

        self.requestedPage = page;
        let request = ApiRequest.Get(url:self.getUrl(), headers: self.headers());

        let data = try await self.apiClient.httpRequestAsync(request)
        
//        let resultString = String(data: data, encoding: .utf8);
//        print(resultString);
        
        if let result = self.mapDataToEntities([Entry].self, data:data) {

            return result;
        } else {
            return [];
        }
    }
    
}
