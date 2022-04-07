//
//  ApiClient.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 17/02/2022.
//

import Foundation

struct ApiRequestBody {
    var body : [String:String];
    
    func toData() throws -> Data {
        let jsonData = try JSONSerialization.data(withJSONObject: self.body, options: [])

        return jsonData

    }
}

typealias ApiRequestHeaders = [String:String]


enum ApiRequest {
    case Get(url:String, headers: ApiRequestHeaders?)
    case Post(url:String, body: ApiRequestBody, headers: ApiRequestHeaders?)
    case Patch(url:String, body: ApiRequestBody, headers: ApiRequestHeaders?)
    case Delete(url:String, body: ApiRequestBody, headers: ApiRequestHeaders?)
}

protocol ApiClient {
    func httpRequestAsync(_ request: ApiRequest, progress:((Double) -> Void)?) async throws -> Data
    func httpRequest(_ request: ApiRequest, progress:((Double) -> Void)?, completion: @escaping (_ data: Data?, _ error: Error?) -> Void)

}


extension ApiClient {
    func httpRequestAsync(_ request: ApiRequest, progress:((Double) -> Void)?) async throws -> Data {
        try await withCheckedThrowingContinuation({ cont in
            self.httpRequest(request, progress: progress) { data, error in
                if let error = error {
                    cont.resume(throwing: error)
                    return
                }
                cont.resume(returning: data!)
            }
        })
    }
}
