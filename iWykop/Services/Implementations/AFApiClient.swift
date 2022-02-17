//
//  AFApiClient.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 17/02/2022.
//

import Foundation
import Alamofire

class AFNetworkApiClient : ApiClient {
    func httpRequest(_ request: ApiRequest, completion: @escaping (Data?, Error?) -> Void) {
        
        var requestUrl = "";
        var requestBody : ApiRequestBody?;
        var method = HTTPMethod.get;
        
        switch (request){
            
        case .Get(url: let url):
            requestUrl = url;
            
        case .Post(url: let url, body: let body):
            requestUrl = url;
            requestBody = body;
            method = .post;
            
        case .Patch(url: let url, body: let body):
            requestUrl = url;
            requestBody = body;
            method = .patch;
            
        case .Delete(url: let url, body: let body):
            requestUrl = url;
            requestBody = body;
            method = .delete;
            
        }
        
        let headers = self.headersFrom(request);
        
        AF.request(requestUrl, method: method, parameters: requestBody?.body, headers: headers).response(completionHandler: { response in
            
            switch response.result {
                
            case .success:
                completion(response.data, nil)
                
            case .failure:
                completion(nil, response.error)
            }
            
            
        });
        
    }
    
    
    func headersFrom(_ apiRequest: ApiRequest) -> HTTPHeaders? {
        //TODO: impl
        return nil;
    }
    
}
