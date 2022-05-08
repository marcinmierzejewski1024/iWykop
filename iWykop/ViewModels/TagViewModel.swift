//
//  TagViewModel.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 15/03/2022.
//

import Foundation
import SwiftUI

enum TagViewMode {
    case Entries
    case Links
    case Both
}

class TagViewModel : BasePushableViewModel {
    
    var mode = TagViewMode.Entries;
    var tag : Tag?;
    @Published var items : [ItemInTag]?
    
    
    init(tag: Tag) {
        super.init()
        self.tag = tag;
        Task {
            await prepareItems();
        }
        
    }
    
    @MainActor public func prepareItems() async {
        let filtered = self.tag?.content?.filter({ item in

            switch self.mode {
            case .Entries:
                return item.entry != nil;
            case .Links:
                return item.link != nil;
            case .Both:
                return true;
            }
        })
        
        
        var withAttributed = [ItemInTag]();
        for filtered in filtered ?? [] {
            var item = filtered;
            if let entry = item.entry {
                let entryAttributed = await self.bodyFormatter.addBodyAttrSingle(es: entry)
                item.entry = entryAttributed as? Entry;
                withAttributed.append(item);
            }
            
            if let link = item.link {
                let linkAttributed = await self.bodyFormatter.addBodyAttrSingle(es: link)
                item.link = linkAttributed as? Link;
                withAttributed.append(item);
            }
        }
        
        self.items = withAttributed;
    }
    
    
    override func prepareView() -> AnyView
    {
        return AnyView(TagView(tagVM: self));
    }
    
    
    
    
    
    
}
