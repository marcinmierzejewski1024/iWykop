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
                    
                    NavigationLink(destination:
                                    LinkDetailsView(link:item, viewModel: self.viewModel)) {
                    LinksListCell(link: item, viewModel: viewModel).onAppear {
                        if item == self.viewModel.displayedLinks.last {
                            Task {
                                await self.viewModel.getNextLinks()
                            }
                        }
                    }.listRowInsets(EdgeInsets()).listRowSeparator(.hidden)
                    }
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
    @ObservedObject var viewModel : LinksViewModel;
    @Environment(\.openURL) var openURL

    
    var body: some View {
        VStack{
            
            CacheAsyncImage(
                url: URL(string:link.preview ?? "")){ phase in
                    switch phase {
                    case .success(let image):
                        VStack(alignment: .leading) {
                            image.resizable()
                                .aspectRatio(contentMode: .fit).fixedSize(horizontal: false, vertical: true)
                        }
                    case .failure(let error):
                        Text(error.localizedDescription)
                        
                    default:
                        Image(systemName: "questionmark")
                        
                    }
                }
            VStack(alignment: .leading) {
                
                Text(link.title ?? "").font(.subheadline).padding(.vertical, 5)
                HStack{
                    Button(link.getSourceDomain() ?? "") {
    //                    openURL(URL(string: link.sourceUrl)!)
                        
                    }

                    Spacer()
                    Image(systemName:"flame.fill")
                    Text("\(link.voteCount)").padding(.trailing, 10)
                    Image(systemName:"text.bubble")
                    Text("\(link.commentsCount)")

                }
//                AuthorView(author: link.author)

                


            }
            
            
        }.padding(0)
        
    }
    
}



