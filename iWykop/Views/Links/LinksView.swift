//
//  LinksView.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 18/02/2022.
//

import SwiftUI
import KSToastView

struct LinksView: View {
    @ObservedObject var linksVM : LinksViewModel;
    
    @ViewBuilder
    var body: some View {
        
        
        
        LinksListView(linksVM: self.linksVM)
        
        
    }
    
    
    struct LinksListView: View {
        
        @ObservedObject var linksVM : LinksViewModel;
        
        
        @ViewBuilder
        var body: some View {
            
            VStack {
                
                
                List() {
                    ForEach(linksVM.displayedLinks, id: \.id) { item in
                        
                        ZStack {
                            
                            
                            LinksListCell(link: item, linksVM: linksVM).onAppear {
                                if item == self.linksVM.displayedLinks.last {
                                    Task {
                                        await self.linksVM.getNextLinks()
                                    }
                                    
                                }
                                
                            }.onTapGesture {
                                BasePushableViewModel.navigation?.pushView(LinkViewModel(link: item).prepareView())
                            }.listRowBackground(WykopColors.shared.currentTheme.backgroundColor.ignoresSafeArea())
                            
                            
                        }.listRowInsets(EdgeInsets()).listRowSeparator(.hidden).listRowBackground(WykopColors.shared.currentTheme.backgroundColor.ignoresSafeArea()).padding(.bottom, Margins.huge.rawValue)
                        

                        
                        
                    }.listRowBackground(WykopColors.shared.currentTheme.backgroundColor.ignoresSafeArea())
                }.listStyle(PlainListStyle()).refreshable {
                    Task {
                        
                        await self.linksVM.refreshCurrentCollectionsLinks()
                    }
                }
                
            }
            
        }
    }
    
}


struct LinksListCell: View {
    var link: Link;
    @ObservedObject var linksVM : LinksViewModel;
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
                                    .aspectRatio(contentMode: .fit).frame(maxWidth: 150, maxHeight: 150)
                            }

                        default:
                            Image("placeholder").resizable()
                                .aspectRatio(contentMode: .fit)
                            
                        }
                    }.frame(width: 180)

                LinkHeader(link: link, displayDescription: true)
            }.padding(0).modifier(CardStyle())

        }
        
        
        
        
        
        
    }
    
}



struct LinkHeader : View {
    var link: Link;
    var displayDescription: Bool;
    
    @Environment(\.openURL) var openInExternalSafari
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text(BodyFormater.replaceOtherSymbols(link.title ?? "")).modifier(TitleStyle()).padding([.leading,.top,.trailing],Margins.medium.rawValue)
            if(displayDescription) {
                Text(BodyFormater.replaceOtherSymbols(link.description ?? "")).modifier(BodyStyle()).padding(.trailing, 100).padding(.leading,Margins.medium.rawValue)

            }
            HStack{
                Button(link.getSourceDomain() ?? "") {
//                    openInExternalSafari(URL(string: link.sourceUrl)!)
                }
                
                Spacer()
                Image(systemName: (link.isHot ? "flame.fill" : "arrow.up")).modifier(BodyStyle())
                Text("\(link.voteCount)").padding(.trailing, Margins.medium.rawValue).modifier(BodyStyle())
                Image(systemName:"text.bubble").modifier(BodyStyle())
                Text("\(link.commentsCount)").modifier(BodyStyle())
                
            }.padding(.horizontal, Margins.medium.rawValue).padding(.vertical, Margins.medium.rawValue)
            //                AuthorView(author: link.author)
            
        }
    }
}
