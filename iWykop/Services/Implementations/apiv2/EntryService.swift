//
//  EntryService.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 20/02/2022.
//

import Foundation


class EntryService : ApiV2Service {
    

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
        
        let resultString = String(data: data, encoding: .utf8);
        print(resultString);
        
        let decoder = JSONDecoder()

        do {
            let respo = try decoder.decode(ApiV2Response<Entry>.self, from: data)

            return respo.data!;
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
        
        return nil;
    }
    
}
