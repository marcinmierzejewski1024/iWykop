//
//  TagView.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 15/03/2022.
//

import Foundation
import SwiftUI




struct TagView : View {
    @EnvironmentObject var settings: SettingsStore

    @ObservedObject var viewModel : TagViewModel;
    
    
    var body: some View {
        
        
        VStack {
            
            List(){
                
                ForEach(self.viewModel.items ?? [], id: \.self ) { item in
                    
                    if (item.hasAdultContent() == false || settings.plus18Enabled ) {
                        
                        ItemInTagView(item: item).listRowInsets(EdgeInsets()).listRowSeparator(.hidden)
                        WykopColors.currentTheme.backgroundColor.frame( height: 10, alignment: .center).listRowInsets(EdgeInsets()).listRowSeparator(.hidden)
                    }
                    
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

