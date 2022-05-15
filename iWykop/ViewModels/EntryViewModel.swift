//
//  EntryViewModel.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 14/03/2022.
//

import Foundation
import Resolver
import OrderedCollections
import KSToastView
import SwiftUI


class EntryViewModel : BasePushableViewModel
{
    @Published var entry : Entry;
    init(entry : Entry) {
        self.entry = entry;
    }
    lazy var entryService: EntryService = resolver.resolve()
    
    
    func refreshEntry(_ old:Entry) async -> Entry? {
        
        do {
            var newEntry = try await entryService.getEntry(id: old.id);
            newEntry = await self.withAttributedBody(newEntry!);
            
            return newEntry;
            
            
        } catch {
            print(error);
            DispatchQueue.main.async {
                KSToastView.ks_showToast(error.localizedDescription);
            }

        }
        
        return nil;
    }
    
    func withAttributedBody(_ entry:Entry) async -> Entry? {
        let withAttributedBody = await bodyFormatter.addBodyAttrSingle(es: entry)
        
        return withAttributedBody as? Entry;

    }
    
    override func prepareView() -> AnyView {
        return AnyView(EntryDetailsView(entryVM: self).task {
            await self.refreshEntry(self.entry)
        }.onOpenURL(perform: { url in
            self.handle(url: url)
        }));
    }
    
    
    override func handle(url: URL){

        if(url.absoluteString.contains("iwykop:spoiler:")) {

            Task {
                self.entry = await withSpoiler(self.entry, spoiler: url) ?? self.entry;
            }

        }
    }

    
    func withSpoiler(_ entry:Entry, spoiler:URL) async -> Entry? {
        let withSpoiler = await bodyFormatter.showSpoiler(es: entry, spoiler: spoiler)
        
        return withSpoiler as? Entry;

    }

}

