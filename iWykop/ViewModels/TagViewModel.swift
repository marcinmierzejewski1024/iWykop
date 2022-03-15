//
//  TagViewModel.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 15/03/2022.
//

import Foundation
import SwiftUI

class TagViewModel : BasePushableViewModel {

    var tagName = "#awww";
    var otherTags = [TagViewModel]();
    
    
    init(name: String) {
        super.init()
        
        self.tagName = name;
        if(tagName == "tag1"){
            self.otherTags = [TagViewModel(name: "#monotyp"),TagViewModel(name: "#eeeee"),TagViewModel(name: "#wwwww")];
        }
        
        if(tagName == "#monotyp"){
            self.otherTags = [TagViewModel(name: "#ttt"),TagViewModel(name: "#aaaa"),TagViewModel(name: "#gfkjkgfj")];
        }
        if(tagName == "#ttt"){
            self.otherTags = [TagViewModel(name: "#asEWWE"),TagViewModel(name: "#DSDSD"),TagViewModel(name: "#NBNBN")];
        }
    }
    
    
    override func prepareView() -> AnyView
    {
        return AnyView(TagView(viewModel: self));
    }
    

    
    
    
    
}
