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
                                BasePushableViewModel.navigation?.pushView(LinkViewModel(link: item).prepareView())
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
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    
    var body: some View {
        
        if horizontalSizeClass == .compact {
            VStack{
                CacheAsyncImage(
                    url: URL(string:link.getFullPreviewImageURL() ?? "")){ phase in
                        switch phase {
                        case .success(let image):
                            VStack(alignment: .leading) {
                                image.resizable()
                                    .aspectRatio(contentMode: .fit).frame( maxHeight: 250).fixedSize(horizontal: false, vertical: false)
                            }
                        default:
                            Image("placeholder").resizable()
                                .aspectRatio(contentMode: .fit)
                            
                        }
                    }
                LinkHeader(link: link, displayDescription: false)
                
            }.padding(0).modifier(CardStyle())
        } else {
            HStack {
                CacheAsyncImage(
                    url: URL(string:link.getFullPreviewImageURL() ?? "")){ phase in
                        switch phase {
                        case .success(let image):
                            VStack(alignment: .leading) {
                                image.resizable()
                                    .aspectRatio(contentMode: .fit).frame( maxWidth: 150)
                            }

                        default:
                            Image("placeholder").resizable()
                                .aspectRatio(contentMode: .fit)
                            
                        }
                    }

                LinkHeader(link: link, displayDescription: true)
            }

        }
        
        
        
        
        
        
    }
    
}



struct LinkHeader : View {
    var link: Link;
    var displayDescription: Bool;
    
    @Environment(\.openURL) var openURL
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text(BodyFormater.replaceOtherSymbols(link.title ?? "")).modifier(TitleStyle()).padding([.leading,.top,.trailing],Margins.medium.rawValue)
            if(displayDescription) {
                Text(BodyFormater.replaceOtherSymbols(link.description ?? "")).modifier(BodyStyle()).padding(.trailing, 100).padding(.leading,Margins.medium.rawValue)

            }
            HStack{
                Button(link.getSourceDomain() ?? "") {
                    openURL(URL(string: link.sourceUrl)!)
                }
                
                Spacer()
                Image(systemName: (link.isHot ? "flame.fill" : "arrow.up")).modifier(BodyStyle())
                Text("\(link.voteCount)").padding(.trailing, Margins.medium.rawValue).modifier(BodyStyle())
                Image(systemName:"text.bubble").modifier(BodyStyle())
                Text("\(link.commentsCount)").modifier(BodyStyle())
                
            }.padding(.horizontal, Margins.medium.rawValue).padding(.top, Margins.small.rawValue)
            //                AuthorView(author: link.author)
            
        }
    }
}
