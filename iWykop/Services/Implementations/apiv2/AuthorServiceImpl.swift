//
//  AuthorServiceImpl.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 15/07/2022.
//

import Foundation

class AuthorServiceImpl : ApiV2Service, AuthorService {
    
    private var requestedLogin = "";
    
    override func getPath() -> String {
        "/Profiles/Index/\(requestedLogin)/"
    }
    
    

    
    func getAuthor(name: String) async throws -> Author? {
        
        self.requestedLogin = name;
        let request = ApiRequest.get(url:self.getUrl(), headers: self.headers());

        let data = try await self.apiClient.httpRequestAsync(request)
        
//        let resultString = String(data: data, encoding: .utf8);
//        print(resultString);
        
        if let result = self.mapDataToEntities(Author.self, data:data) {

            return result.data;
        } else {
            return nil;
        }

    }
    
    
}
