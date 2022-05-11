//
//  TagView.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 15/03/2022.
//

import Foundation
import SwiftUI




struct TagView : View {

    @ObservedObject var tagVM : TagViewModel;
    
    
    var body: some View {
        
        
        ZStack {
            
            List(){
                
                ForEach(self.tagVM.items ?? [], id: \.self ) { item in
                    ZStack {
                        if (item.hasAdultContent() == false || tagVM.settingsStore.plus18Enabled ) {
                            
                            ItemInTagView(item: item)
                        }
                    }.listRowBackground(WykopColors.shared.currentTheme.backgroundColor.ignoresSafeArea()).listRowInsets(EdgeInsets()).listRowSeparator(.hidden).padding(.bottom, Margins.medium.rawValue)
                    
                }
            }.listStyle(PlainListStyle()).refreshable {
                Task {
                    
//                    await self.viewModel.refreshCurrentCollectionsLinks()
                }
            }.onOpenURL { url in
                self.tagVM.handle(url: url)
            }
            
        }.navigationTitle(tagVM.tag?.meta?.tag ?? "").padding(0)
        
    }
}



struct ItemInTagView : View {
    
    var item :ItemInTag;
    
    @ViewBuilder
    var body: some View {
        
        switch item.type {
        case .link:
            LinkDetailsView(link: item.link!, linkVM: LinkViewModel(link: item.link!)).onTapGesture {
                BasePushableViewModel.navigation?.pushView(LinkViewModel(link: item.link!).prepareView())
                
            }
        case .entry:
            EntryViewCell(entry: item.entry!).onTapGesture {
                BasePushableViewModel.navigation?.pushView(EntryViewModel(entry: item.entry!).prepareView())
                
            }
        }
        
    }
    
}

