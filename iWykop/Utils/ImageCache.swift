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
    static let cacheSize = 120;
    static let sharedInstance = ImageCache()
    
    lazy var networkClient : AFNetworkApiClient = resolver.resolve();
    
    private var cache: [(URL, Image?)] = []
    
    var inProgress = [URL]();
    
    
    public subscript(url: URL) -> Image? {
        get {
            for cacheEntry in self.cache {
                if (cacheEntry.0 == url) {
                    return cacheEntry.1;
                }
            }
            return nil;
        }
        set {
            self.cache.append((url, newValue));
            self.cleanOverLimit();
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
                
                
                if(self[key] != nil){
                    print("stop preloading image already in cache \(String(describing: url))")
                    return;
                }
                if self.inProgress.contains(key) {
                    print("stop preloading image already in progress \(String(describing: url))")
                    return;
                }
                
                print("start loading!!! \(String(describing: url))")

                self.inProgress.append(key);
            }
            networkClient.getFile(from: url!, progress: nil) { data, err in
                if let data = data {
                    if let image = UIImage(data: data) {
                        let imageToBeCached = Image(uiImage: image)
                        synced(ImageCache.sharedInstance) {
                            self[key] = imageToBeCached;
                        }
                    }
                }

                synced(ImageCache.sharedInstance) {
                    self.inProgress.removeAll { inProgress in
                        return key == inProgress;
                    };
                }
                
            }
        }
    }
    
    func cleanOverLimit()
    {
        while(self.cache.count > ImageCache.cacheSize) {
            self.cache.removeFirst()
        }
    }
}




func synced(_ lock: Any, closure: () -> ()) {
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}
