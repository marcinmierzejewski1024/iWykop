//
//  ApiClient.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 17/02/2022.
//

import Foundation

public struct ApiRequestBody {
    var body : [String:String];
    
    func toData() throws -> Data {
        let jsonData = try JSONSerialization.data(withJSONObject: self.body, options: [])

        return jsonData

    }
}

public typealias ApiRequestHeaders = [String:String]


public enum ApiRequest {
    case Get(url:String, headers: ApiRequestHeaders?)
    case Post(url:String, body: ApiRequestBody, headers: ApiRequestHeaders?)
    case Patch(url:String, body: ApiRequestBody, headers: ApiRequestHeaders?)
    case Delete(url:String, body: ApiRequestBody, headers: ApiRequestHeaders?)
}

public protocol ApiClient {
    func httpRequestAsync(_ request: ApiRequest) async throws -> Data
    func httpRequest(_ request: ApiRequest, completion: @escaping (_ data: Data?, _ error: Error?) -> Void)

    func getFile(from url: String, progress:((Double) -> Void)?, completion: @escaping (_ data: Data?, _ error: Error?) -> Void)

}


extension ApiClient {
    public func httpRequestAsync(_ request: ApiRequest) async throws -> Data {
        try await withCheckedThrowingContinuation({ cont in
            self.httpRequest(request) { data, error in
                if let error = error {
                    cont.resume(throwing: error)
                    return
                }
                cont.resume(returning: data!)
            }
        })
    }
}
