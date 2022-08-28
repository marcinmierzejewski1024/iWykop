//
//  URLSessionApiClient.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 07/04/2022.
//

import Foundation

public class DownloadTaskHandler : Hashable {
    
    var completion: ((Data?, Error?) -> Void)?
    var task : URLSessionDownloadTask?
    
    public static func == (lhs: DownloadTaskHandler, rhs: DownloadTaskHandler) -> Bool {
        return lhs.task == rhs.task
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(task)
    }
}

public class URLSessionApiClient : NSObject, ApiClient, URLSessionDelegate {
    
    var handlers = [DownloadTaskHandler]()
    var observation :NSKeyValueObservation?
    lazy var session:URLSession = {
        return URLSession(configuration:URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
    }()
    
    
    public func getFile(from url: String, progress: ((Double) -> Void)?, completion: @escaping (Data?, Error?) -> Void) {
        
        guard let url = URL(string: url) else {
            completion(nil, "invalid URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        let handler = DownloadTaskHandler()
        handler.completion = completion
        
        handlers.append(handler)
        
        let downloadTask = session.downloadTask(with: urlRequest)
        handler.task = downloadTask
        
        self.observation = downloadTask.progress.observe(\.fractionCompleted) { downloadingProgress, _ in
            print("\(downloadingProgress.fractionCompleted) ---+")
            progress?(downloadingProgress.fractionCompleted)
        }
        
        downloadTask.resume()
        
        
        
    }
    
    
    
    public func httpRequest(_ request: ApiRequest, completion: (@escaping (Data?, Error?) -> Void)) {
        
        var urlString : String?
        var connectionBody : Data?
        let httpMethod = request.method()
        var connectionHeaders : ApiRequestHeaders?
        
        do {
            switch request {
            case .get(let url, let headers):
                urlString = url
                connectionHeaders = headers
                
            case .post(let url, let body, let headers):
                urlString = url
                connectionBody = try body.toData()
                connectionHeaders = headers
                
                
            case .delete(let url, let body, let headers):
                urlString = url
                connectionBody = try body.toData()
                connectionHeaders = headers
                
            }
        } catch {
            completion(nil, error)
        }
        
        if let urlString = urlString {
            
            let urlFromString = URL(string: urlString)!
            var urlRequest = URLRequest(url: urlFromString)
            urlRequest.httpBody = connectionBody
            urlRequest.httpMethod = httpMethod
            urlRequest.allHTTPHeaderFields = connectionHeaders
            
            let dataTask = session.dataTask(with: urlRequest) { data, response, error in
                completion(data, error)
            }
            
            dataTask.resume()
        }
        
    }
    
}



extension URLSessionApiClient : URLSessionDownloadDelegate {
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let handler = handlers.first { handler in
            handler.task == downloadTask
        }
        defer {
            handlers.removeAll { candidate in
                candidate == handler
            }
        }
        
        do {
            let rawData = try Data(contentsOf: location)
            handler?.completion?(rawData, nil)
        } catch {
            handler?.completion?(nil, error)
        }
    }
    
    
}
