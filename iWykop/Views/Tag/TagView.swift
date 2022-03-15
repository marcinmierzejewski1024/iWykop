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

                if(self.viewModel.parentViewModel != nil) {
                    Text("back").font(.caption).padding().onTapGesture {
                            viewModel.dissmissSelf();
                    }
                }
                
                List(){
                    Text("List:")
                    
                    ForEach(self.viewModel.otherTags, id: \.tagName ) { item in
                        Text(item.tagName).onTapGesture {
                            
                            viewModel.presentChildViewModel(item);
                        }
                    }
                }
            }.navigationTitle(viewModel.tagName)
        
    }
}
