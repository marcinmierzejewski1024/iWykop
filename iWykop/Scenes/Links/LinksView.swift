//
//  LinksView.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 18/02/2022.
//

import SwiftUI

struct LinksView: View {
    @ObservedObject var viewModel : LinksViewModel;
    
    @ViewBuilder
    var body: some View {
        
        
        NavigationView {
            
                
                LinksListView(viewModel: self.viewModel)
                
            
            
        }.navigationViewStyle(.stack)
        
    }
    
    
    struct LinksListView: View {
        
        @ObservedObject var viewModel : LinksViewModel;
        
        
        @ViewBuilder
        var body: some View {
            
            
            List() {
                ForEach(viewModel.links, id: \.id) { item in
                    
                    Text(item.url)
                    
                    
                }
            }.padding(0).refreshable {
                Task {
                    
                    await self.viewModel.refreshLinks()
                }
            }
            
            
            
        }
    }
    
}





