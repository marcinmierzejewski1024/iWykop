//
//  URLSessionApiClient.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 07/04/2022.
//

import Foundation
import Alamofire

class URLSessionApiClient : ApiClient {
    func httpRequest(_ request: ApiRequest, progress: ((Double) -> Void)?, completion: (@escaping (Data?, Error?) -> Void)) {
     
        var sessionMethod : HTTPMethod?;
        var urlString : String?;
        var sessionHeaders : HTTPHeaders?;
        var sessionBody : Data?;
        
        switch request {
        case .Get(let url, let headers):
            sessionMethod = .get;
            urlString = url;
            sessionHeaders = HTTPHeaders(headers ?? [:]);
        case .Post(let url, let body, let headers):
            sessionMethod = .post;
            urlString = url;
            sessionBody = try! body.toData()
            sessionHeaders = HTTPHeaders(headers ?? [:]);

        case .Patch(let url, let body, let headers):
            sessionMethod = .patch;
            urlString = url;
            sessionBody = try! body.toData()
            sessionHeaders = HTTPHeaders(headers ?? [:]);
            
        case .Delete(let url, let body, let headers):
            sessionMethod = .delete;
            urlString = url;
            sessionBody = try! body.toData()
            sessionHeaders = HTTPHeaders(headers ?? [:]);
        }
        
        var urlRequest = try! URLRequest(url: urlString!, method: sessionMethod!, headers: sessionHeaders)
        urlRequest.httpBody = sessionBody;
        
        var dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            completion(data,error);
        }

//        dataTask.pr
        dataTask.resume();
    }
    
}
