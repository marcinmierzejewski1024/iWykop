//
//  CacheAsyncImage.swift
//  CacheAsyncImage
//
//  Created by Pedro Rojas on 13/08/21.
//

import SwiftUI

struct CacheAsyncImage<Content>: View where Content: View {

    private let url: URL?
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content

    init(
        url: URL?,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }

    var body: some View {

        if let url = url {
            if let cached = ImageCache.sharedInstance[url] {
                let _ = print("cached \(url.absoluteString)")
                content(.success(cached))
            } else {
                let _ = print("request \(url.absoluteString)")
                let _ = synced(ImageCache.sharedInstance) {
                    ImageCache.sharedInstance.inProgress.append(url);
                }
                AsyncImage(
                    url: url,
                    scale: scale,
                    transaction: transaction
                ) { phase in
                    cacheAndRender(phase: phase)
                }
            }
            
        } else {

        }
    }

    func cacheAndRender(phase: AsyncImagePhase) -> some View {
        
        if case .success(let image) = phase {
            if let url = url {
                synced(ImageCache.sharedInstance) {
                    ImageCache.sharedInstance[url] = image
                    ImageCache.sharedInstance.inProgress.removeAll { inProgress in
                        return url == inProgress;
                    };
                }

            }
        }

        return content(phase)
    }
}



