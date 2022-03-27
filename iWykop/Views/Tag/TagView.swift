//
//  TagView.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 15/03/2022.
//

import Foundation
import SwiftUI




struct TagView : View {
    @ObservedObject var viewModel : TagViewModel;
    
    
    var body: some View {
        
        
        VStack {
            NavigationLink(destination: self.viewModel.childView(), isActive: $viewModel.childViewActive) { EmptyView() }
            
            
            List(){
                
                ForEach(self.viewModel.items ?? [], id: \.self ) { item in
                    
                    ItemInTagView(item: item)
                }
            }
            
        }.navigationTitle(viewModel.tag?.meta?.tag ?? "")
        
    }
}



struct ItemInTagView : View {
    
    var item :ItemInTag;
    
    @ViewBuilder
    var body: some View {
        
        switch item.type {
        case .link:
            LinkDetailsView(link: item.link!, viewModel: LinkViewModel(link: item.link!))
        case .entry:
            EntryViewCell(entry: item.entry!)
        }
        
    }
    
}

