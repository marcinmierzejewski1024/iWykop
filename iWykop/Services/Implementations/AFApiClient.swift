//
//  AFApiClient.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 17/02/2022.
//

import Foundation
import Alamofire


class AFNetworkApiClient : ApiClient {
    
    func getFile(from url: String, progress: ((Double) -> Void)?, completion: @escaping (Data?, Error?) -> Void) {
        let progressStream = AF.download(url).responseData { response in
            
            if let fileDownloadedUrl = response.fileURL {
                do {
                let data = try Data(contentsOf: fileDownloadedUrl)
                    completion(data, nil)

                } catch {
                    completion(nil, error)

                }
            } else {
                completion(nil, response.error)
            }
            
        }.downloadProgress();
        

    
    }
    
    
    
    
    func httpRequest(_ request: ApiRequest, completion: (@escaping (Data?, Error?) -> Void)) {
        
        var requestUrl = "";
        var requestBody :ApiRequestBody?;
        var method = HTTPMethod.get;
        var requestHeaders :HTTPHeaders?;
        
        switch (request){

            
        case .Get(url: let url, headers: let headers):
            method = .get;
            requestUrl = url;
            requestHeaders = self.headersFrom(headers)
            
        case .Post(url: let url, body: let body, headers: let headers):
            method = .post;
            requestUrl = url;
            requestHeaders = self.headersFrom(headers)
            requestBody = body;

        case .Patch(url: let url, body: let body, headers: let headers):
            method = .patch;
            requestUrl = url;
            requestHeaders = self.headersFrom(headers)
            requestBody = body;


        case .Delete(url: let url, body: let body, headers: let headers):
            method = .delete;
            requestUrl = url;
            requestHeaders = self.headersFrom(headers)
            requestBody = body;


        }
        
        
        AF.request(requestUrl, method: method, parameters: requestBody?.body, headers: requestHeaders).response(completionHandler: { response in
            
            switch response.result {
                
            case .success:
                completion(response.data, nil)
                
            case .failure:
                completion(nil, response.error)
            }
            
            
        });
        
    }
    
    
    func headersFrom(_ inh: [String:String]?) -> HTTPHeaders? {
        

        let headers = inh?.compactMap({ (key: String, value: String) in
            return HTTPHeader(name: key, value: value);

        })
        
        return HTTPHeaders(headers ?? []);
    }
    
    
}




