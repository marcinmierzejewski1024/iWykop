//
//  LinksView.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 18/02/2022.
//

import SwiftUI
import KSToastView

struct LinksView: View {
    @ObservedObject var viewModel : LinksViewModel;
    
    @ViewBuilder
    var body: some View {
        
        
            
            LinksListView(viewModel: self.viewModel)
            
        
    }
    
    
    struct LinksListView: View {
        
        @ObservedObject var viewModel : LinksViewModel;
        
        
        @ViewBuilder
        var body: some View {
            
            VStack {
                NavigationLink(destination: self.viewModel.childView(), isActive: $viewModel.childViewActive) { EmptyView() }.hidden()
                
                
                List() {
                    ForEach(viewModel.displayedLinks, id: \.id) { item in
                        
                        ZStack {
                            
                            
                            LinksListCell(link: item, viewModel: viewModel).onAppear {
                                if item == self.viewModel.displayedLinks.last {
                                    Task {
                                        await self.viewModel.getNextLinks()
                                    }
                                    
                                }
                                
                            }.onTapGesture {
                                self.viewModel.presentChildViewModel(LinkViewModel(link: item))
                            }
                            
                            
                        }.listRowInsets(EdgeInsets()).listRowSeparator(.hidden)
                        
                        WykopColors.currentTheme.backgroundColor.frame( height: 20, alignment: .center).listRowInsets(EdgeInsets()).listRowSeparator(.hidden)
                        
                        
                    }
                }.listStyle(PlainListStyle()).refreshable {
                    Task {
                        
                        await self.viewModel.refreshCurrentCollectionsLinks()
                    }
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
                url: URL(string:link.getFullPreviewImageURL() ?? "")){ phase in
                    switch phase {
                    case .success(let image):
                        VStack(alignment: .leading) {
                            image.resizable()
                                .aspectRatio(contentMode: .fit).frame( maxHeight: 250).fixedSize(horizontal: false, vertical: false)
                        }
                    case .failure(let error):
                        Text(error.localizedDescription)
                        
                    default:
                        Image("placeholder").resizable()
                            .aspectRatio(contentMode: .fit)
                        
                    }
                }
            VStack(alignment: .leading) {
                
                Text(link.title ?? "").modifier(TitleStyle()).padding(Margins.medium.rawValue)
                HStack{
                    Button(link.getSourceDomain() ?? "") {
                        //                    openURL(URL(string: link.sourceUrl)!)
                        
                    }
                    
                    Spacer()
                    Image(systemName: (link.isHot ? "flame.fill" : "arrow.up")).modifier(BodyStyle())
                    Text("\(link.voteCount)").padding(.trailing, Margins.medium.rawValue).modifier(BodyStyle())
                    Image(systemName:"text.bubble").modifier(BodyStyle())
                    Text("\(link.commentsCount)").modifier(BodyStyle())
                    
                }.padding(.horizontal, Margins.medium.rawValue)
                //                AuthorView(author: link.author)
                
                
                
                
            }
            
            
        }.padding(0).modifier(CardStyle())
        
    }
    
}



