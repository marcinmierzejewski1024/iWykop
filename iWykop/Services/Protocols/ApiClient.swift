//
//  ApiClient.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 17/02/2022.
//

import Foundation

struct ApiRequestBody {
    var body : [String:String];
//    var headers : [String:String]; ??

}

enum ApiRequest {
    case Get(url:String)
    case Post(url:String, body: ApiRequestBody)
    case Patch(url:String, body: ApiRequestBody)
    case Delete(url:String, body: ApiRequestBody)
}

protocol ApiClient {
    func httpRequestAsync(_ request: ApiRequest) async throws -> Data
    func httpRequest(_ request: ApiRequest, completion: @escaping (_ data: Data?, _ error: Error?) -> Void)

}


extension ApiClient {
    func httpRequestAsync(_ request: ApiRequest) async throws -> Data {
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
