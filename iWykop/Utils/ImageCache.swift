//
//  ImageCache.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 25/03/2022.
//

import Foundation
import SwiftUI
import Resolver

class ImageCache : Resolving {
    static let sharedInstance = ImageCache()
    
    lazy var networkClient : AFNetworkApiClient = resolver.resolve();
    
    static private var cache: [URL: Image] = [:]
    static var inProgress = [URL]();
    
    
    static subscript(url: URL) -> Image? {
        get {
            ImageCache.cache[url]
        }
        set {
            ImageCache.cache[url] = newValue
        }
    }
    
    private init(){
        
    }
    
    
    func preloadImage(url:String?)
    {
        guard url != nil else {
            return;
        }
        
        if let key = URL(string: url!) {
            
            synced(ImageCache.sharedInstance) {
                
                
                if(ImageCache[key] != nil){
                    print("stop preloading image already in cache \(url)")
                    return;
                }
                if ImageCache.inProgress.contains(key) {
                    print("stop preloading image already in progress \(url)")
                    return;
                }
                
                print("start loading!!! \(url)")

                ImageCache.inProgress.append(key);
            }
            networkClient.httpRequest(ApiRequest.Get(url: url!, headers: nil)) { data, err in
                if let data = data {
                    if let image = UIImage(data: data) {
                        let imageToBeCached = Image(uiImage: image)
                        synced(ImageCache.sharedInstance) {
                            ImageCache[key] = imageToBeCached;
                        }
                    }
                }

                synced(ImageCache.sharedInstance) {
                    ImageCache.inProgress.removeAll { inProgress in
                        return key == inProgress;
                    };
                }
                
            }
        }
    }
}


func synced(_ lock: Any, closure: () -> ()) {
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}
