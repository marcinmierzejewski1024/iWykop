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
    
    
    init(tag: Tag) {
        super.init()
        self.tag = tag;
        
    }
    
    public func items() -> [ItemInTag]? {
        return self.tag?.content?.filter({ item in

            switch self.mode {
            case .Entries:
                return item.entry != nil;
            case .Links:
                return item.link != nil;
            case .Both:
                return true;
            }
        })
    }
    
    
    override func prepareView() -> AnyView
    {
        return AnyView(TagView(viewModel: self));
    }
    
    
    
    
    
    
}
