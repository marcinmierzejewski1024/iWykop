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


class EmbedViewModel : BasePushableViewModel
{
    @Published var downloadProgress : Float = 0.2;
    @Published var embed : Embed;
    
    init(embed : Embed) {
        self.embed = embed;
    }
    
    
    func loadData() async {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.downloadProgress = 0.4;
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.downloadProgress = 0.5;
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.downloadProgress = 0.6;
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.downloadProgress = 0.8;
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.downloadProgress = 1.0;
        }
        
        
//        do {
//            var newEntry = try await entryService.getEntry(id: old.id);
//            newEntry = await self.withAttributedBody(newEntry!);
//
//            return newEntry;
            
            
//        } catch {
//            print(error);
//            DispatchQueue.main.async {
//                KSToastView.ks_showToast(error.localizedDescription);
//            }

//        }
        
    }
    
    func fullImage() -> Image? {
        return nil;
    }
    
    func previewImage() -> Image? {
        return nil;
    }
    
    
    override func prepareView() -> AnyView {
        return AnyView(EmbedBodyPreview(viewModel: self).task {
            await self.loadData()
        });
    }
    
    
}

