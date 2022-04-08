//
//  URLSessionApiClient.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 07/04/2022.
//

import Foundation
import Alamofire

class URLSessionApiClient : NSObject, ApiClient, URLSessionDelegate, URLSessionDataDelegate {
    
    var session:URLSession?

    
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
        
        
        let configuration = URLSessionConfiguration.default
        let mainqueue = OperationQueue.main
        if (self.session == nil) {
            session = URLSession(configuration: configuration, delegate:self, delegateQueue: nil)
        }

        let dataTask = session!.dataTask(with: urlRequest) { data, response, error in
            completion(data,error);
        }
        
        dataTask.delegate = self;

        dataTask.resume();
    }

//    func URLSession(session: URLSession, dataTask: URLSessionDataTask, didReceiveResponse response: URLResponse, completionHandler: (URLSessionResponseDisposition) -> Void) {
//        completionHandler(URLSessionResponseDisposition.Allow) //.Cancel,If you want to stop the download
//    }

    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
                print("didReceive222");

    }
//    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
//        print("didReceive");
//    }
}
