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
                ForEach(viewModel.displayedLinks, id: \.id) { item in
                    
                    LinksListCell(link: item).onAppear {
                        if item == self.viewModel.displayedLinks.last {
                            Task {
                                await self.viewModel.getNextLinks()
                            }
                        }
                    }.listRowInsets(EdgeInsets()).listRowSeparator(.hidden)
                    
                    WykopColors.backgroundColor.frame( height: 20, alignment: .center).listRowInsets(EdgeInsets()).listRowSeparator(.hidden)
                    
                    
                }
            }.listStyle(PlainListStyle()).refreshable {
                Task {
                    
                    await self.viewModel.refreshCurrentCollectionsLinks()
                }
            }
            
            
            
        }
    }
    
}


struct LinksListCell: View {
    var link: Link;
    @Environment(\.openURL) var openURL

    
    var body: some View {
        HStack{
            
            CacheAsyncImage(
                url: URL(string:link.preview ?? "")){ phase in
                    switch phase {
                    case .success(let image):
                        VStack(alignment: .leading) {
                            image.resizable()
                                .aspectRatio(contentMode: .fit).frame(width: 120, height: 120)
                        }
                    case .failure(let error):
                        Text(error.localizedDescription)
                        
                    default:
                        Image(systemName: "questionmark")
                        
                    }
                }
            VStack(alignment: .leading) {
                AuthorView(author: link.author)

                
                Button(link.getSourceDomain() ?? "") {
                    openURL(URL(string: link.sourceUrl)!)
                }

            }
            
            
        }.padding(0)
        
    }
    
}



