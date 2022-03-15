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


class EntryViewModel : BasePushableViewModel, Resolving
{
    var entry : Entry;
    init(entry : Entry) {
        self.entry = entry;
    }
    lazy var entryService: EntryService = resolver.resolve()
    
    
    func refreshEntry(_ old:Entry) async -> Entry? {
        
        do {
            let newEntry = try await entryService.getEntry(id: old.id);
            
            return newEntry;
            
            
        } catch {
            print(error);
            DispatchQueue.main.async {
                KSToastView.ks_showToast(error.localizedDescription);
            }

        }
        
        return nil;
    }
    
    
    override func prepareView() -> AnyView {
        return AnyView(EntryDetailsView(entry: self.entry, viewModel: self).task {
            await self.refreshEntry(self.entry)
        });
    }
    
    
}

