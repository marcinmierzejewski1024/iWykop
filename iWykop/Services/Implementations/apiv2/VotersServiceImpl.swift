//
//  VotersServiceImpl.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 21/06/2022.
//

import Foundation

class VotersServiceImpl : ApiV2Service, VotersService  {
    
    var id : Int = 0;
    var getLinkVoters = false;
    var downvotes = false;
    
    override func getPath() -> String {
        if(getLinkVoters) {
            if(downvotes) {
                return "Links/Downvoters/\(id)/"
            } else {
                return "Links/Upvoters/\(id)/"

            }
        } else {
            return "Entries/Upvoters/\(id)/"
        }
    }
    
    override func urlParams() -> [String : String]? {
        var superParams = super.urlParams()!;
        superParams.removeValue(forKey: "data")
        return superParams;
    }
    
    
    func getLinkVoters(id: Int, downvotes: Bool) async throws -> [AuthorWithDate] {
        self.getLinkVoters = true;
        self.id = id;
        self.downvotes = downvotes;
        
        let request = ApiRequest.Get(url:self.getUrl(), headers: self.headers());

        let data = try await self.apiClient.httpRequestAsync(request)
        
        let resultString = String(data: data, encoding: .utf8);
        print(resultString);
        
        if let result = self.mapDataToEntities([AuthorWithDate].self, data:data) {


            return result.data ?? [];
        } else {
            return [];
        }

    }
    
    func getEntryVoters(id: Int) async throws -> [AuthorWithDate] {
        self.getLinkVoters = false;
        self.id = id;
        
        let request = ApiRequest.Get(url:self.getUrl(), headers: self.headers());

        let data = try await self.apiClient.httpRequestAsync(request)
        
        let resultString = String(data: data, encoding: .utf8);
        print(resultString);
        
        if let result = self.mapDataToEntities([AuthorWithDate].self, data:data) {


            return result.data ?? [];
        } else {
            return [];
        }

    }
    
}
