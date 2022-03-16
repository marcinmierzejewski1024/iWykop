//
//  TagServiceImpl.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 16/03/2022.
//

import Foundation

//https://a2.wykop.pl/Tags/Index/page/int/tag/

class TagServiceImpl : ApiV2Service, TagService  {
    private var requestedPage = 0;
    private var requestedTag = "";
    
    override func getPath() -> String {
        "Tags/Index/page/\(requestedPage)/tag/\(requestedTag)"
    }
    
    override func urlParams() -> [String : String]? {
        var superParams = super.urlParams()!;
        
        superParams["data"] = "full";

        return superParams;
    }
    
    
    func getTag(tag: String) async throws -> Tag? {
        let request = ApiRequest.Get(url:self.getUrl(), headers: self.headers());

        let data = try await self.apiClient.httpRequestAsync(request)
        
        
        let resultString = String(data: data, encoding: .utf8);
        print(resultString);
        
        return Tag(meta: nil);


    }

    
}
