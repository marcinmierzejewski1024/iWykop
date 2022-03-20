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
                
                ForEach(self.viewModel.items() ?? [], id: \.self ) { item in
                    
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
        
        if(item.type == "link") {
            LinkDetailsView(link: item.link!, viewModel: LinkViewModel(link: item.link!))
        }
        if(item.type == "entry") {
            EntryViewCell(entry: item.entry!)
        }
        
        //    LinkDetailsView
        //    EntryViewCell
    }
    
}


//List() {
//    
//    ForEach(viewModel.entries, id: \.id) { item in
//        
//        
//        ZStack {
//            
//            
//            EntryViewCell(entry: item).onAppear {
//                if item == self.viewModel.entries.last {
//                    Task {
//                        await self.viewModel.getNextEntries()
//                    }
//                }
//            }.onTapGesture {
//                self.viewModel.presentChildViewModel(EntryViewModel(entry: item))
//            }
//            
//            
//        }
//        
//        
//        
//        WykopColors.currentTheme.backgroundColor.frame( height: 20, alignment: .center).listRowInsets(EdgeInsets()).listRowSeparator(.hidden)
//        
//        
//        
//    }
//}.listStyle(PlainListStyle()).refreshable {
//    Task {
//        
//        await self.viewModel.refreshEntries()
//    }
//}.onOpenURL { url in
//    Task {
//        await self.viewModel.presentFromUrl(url)
//    }
//}
