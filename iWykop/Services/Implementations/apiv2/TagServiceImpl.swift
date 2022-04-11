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
        "Tags/Index/\(requestedTag)/page/\(requestedPage)/"
    }
    
    override func urlParams() -> [String : String]? {
        var superParams = super.urlParams()!;
        
        superParams["data"] = "full";

        return superParams;
    }
    
    
    func getTag(tag: String) async throws -> Tag? {
        self.requestedTag = tag;
        self.requestedTag = "gif";//TODO:skasowac
        
        let request = ApiRequest.Get(url:self.getUrl(), headers: self.headers());

        let data = try await self.apiClient.httpRequestAsync(request)
        
        if let result = self.mapDataToEntities(TagContent.self, data:data) {
        
//            let withAttributedBody = await bodyFormatter.addBodyAttr(es: result.data)
            
            
            var tag = Tag();
            tag.content = result.data;
            tag.meta = result.meta
            return tag;
        }

        
        return nil;


    }

    
}
