//
//  EmbedViewModel.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 02/04/2022.
//


import Foundation
import Resolver
import OrderedCollections
import KSToastView
import SwiftUI
import Combine
import SwiftyGif


class EmbedViewModel : BasePushableViewModel
{
    lazy var apiClient : ApiClient = resolver.resolve();
    @Published var downloadProgress = 0.0;
    @Published var embed : Embed;
    @Published var animatedImageData : Data?;
    
    init(embed : Embed) {
        self.embed = embed;
    }
    
    
    func loadData() {
        
        if let gifUrl = embed.getAnimatedImageUrl() {
            print("starting gif\(gifUrl)")
            
            
            apiClient.getFile(from: gifUrl, progress: { progress in
                DispatchQueue.main.async {
                    print("progress gif\(progress)")
                    self.downloadProgress = progress;
                    self.objectWillChange.send()
                }

            }, completion: { data, error in
                
                if let data = data {
                    DispatchQueue.main.async {
                        self.animatedImageData = data;
                        self.objectWillChange.send()
                    }
                }
                
    //            image from data
            })
        }

        
    }
    
    func fullImage() -> Image? {
        return nil;
    }
    
    func previewImage() -> Image? {
        return nil;
    }
    
    func embedVideoUrl() -> String {
        //TODO:
        return "https://www.youtube.com/embed/Za7YYCasDkE";
    }
    
    override func prepareView() -> AnyView {
        return AnyView(EmbedBodyPreview(embedVM: self));
    }

    
    func prepareModalView() -> AnyView {
        return AnyView(EmbedBodyPreviewWithModal(embedVM: self));
    }

    
}

