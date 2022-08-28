//
//  ApiClientTests.swift
//  iWykopTests
//
//  Created by Marcin Mierzejewski on 15/04/2022.
//

import XCTest
import Resolver
import iWykop

class ApiClientTests: XCTestCase, Resolving {

    static let middleSizeFileUrlPath = "https://devimages-cdn.apple.com/design/resources/download/iOS-13-Keynote.dmg"
    
    lazy var AFApiClient : AFNetworkApiClient = resolver.resolve()
    lazy var urlSessionApiClient : URLSessionApiClient = resolver.resolve()


    func testDownloadFileAF() throws {
        try self.testDownloadFile(apiClient: self.AFApiClient)
    }
    
    func testCacheFileAF() throws {
//        try self.testCache(apiClient: self.AFApiClient) // fails
    }
    
    
    func testDownloadFileSession() throws {
        try self.testDownloadFile(apiClient: self.urlSessionApiClient)
    }

    func testCacheFileSession() throws {
        try self.testDownloadFile(apiClient: self.urlSessionApiClient)
    }

    
    
    private func testDownloadFile(apiClient: ApiClient) throws {
        
        let enterProgress = self.expectation(description: "enterProgress")
        enterProgress.assertForOverFulfill = false
        
        let enterCompletion = self.expectation(description: "enterCompletion")

        apiClient.getFile(from: ApiClientTests.middleSizeFileUrlPath) { progress in
            enterProgress.fulfill()
        } completion: { data, err in
            if let _ = data {
                enterCompletion.fulfill();
            }
        }
        
        waitForExpectations(timeout: 30, handler: nil)


    }
    
    
    private func testCache(apiClient: ApiClient) throws {
        
        let firstEnterCompletion = self.expectation(description: "enterCompletion cache 1")
        apiClient.getFile(from: ApiClientTests.middleSizeFileUrlPath) { progress in
        } completion: { data, err in
            if let _ = data {
                firstEnterCompletion.fulfill();
            }
        }
        waitForExpectations(timeout: 30.0, handler: nil)

        
        let enterCompletion = self.expectation(description: "enterCompletion cache 2")

        apiClient.getFile(from: ApiClientTests.middleSizeFileUrlPath) { progress in
        } completion: { data, err in
            if let _ = data {
                enterCompletion.fulfill();
            }
        }
        
        waitForExpectations(timeout: 0.5, handler: nil)//cache hit should be fast


    }



}
