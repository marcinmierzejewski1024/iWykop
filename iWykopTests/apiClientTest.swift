//
//  apiClientTest.swift
//  iWykopTests
//
//  Created by Marcin Mierzejewski on 15/04/2022.
//

import XCTest
import Resolver
import iWykop

class apiClientTest: XCTestCase, Resolving {

    lazy var AFApiClient : AFNetworkApiClient = resolver.resolve()
    lazy var urlSessionApiClient : URLSessionApiClient = resolver.resolve()


    func testDownloadFileAF() throws {
        try self.testDownloadFile(apiClient: self.AFApiClient)
    }
    
    func testDownloadFileSession() throws {
        try self.testDownloadFile(apiClient: self.urlSessionApiClient)
    }
    
    private func testDownloadFile(apiClient: ApiClient) throws {
        
        let enterProgress = self.expectation(description: "enterProgress")
        let enterCompletion = self.expectation(description: "enterCompletion")

        apiClient.getFile(from: "https://www.immigratemanitoba.com/alt/practise-english-on-your-own.pdf") { progress in
            print(progress)
            enterProgress.fulfill()
        } completion: { data, err in
            if let _ = data {
                enterCompletion.fulfill();
            }
        }
        
        waitForExpectations(timeout: 60, handler: nil)


    }


}
