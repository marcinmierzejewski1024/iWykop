//
//  LinkDetailsView.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 11/03/2022.
//

import SwiftUI
import KSToastView

enum LinkDetailsTabs : String, CaseIterable {
    case Comments = "Comments"
    case VotersUp = "Votes up"
    case VotersDown = "Bury"
    case Attachments = "Attachments"
    case Tags = "Tags"
}

struct LinkDetailsView: View {
    @State var selected = 0;
    @State var link : Link;
    @ObservedObject var linkVM : LinkViewModel;
    
    func selectedTab() -> LinkDetailsTabs {
        return LinkDetailsTabs.allCases[selected];
    }
    
    func reloadLink() {
        
        Task {
            if let new = await linkVM.refreshLink(link) {
                link = new;
            }
        }
    }
    
    var body: some View {
        
        
        
        List() {
            
            VStack (alignment: .leading){
                LinkViewCellHeader(link: link)
                //                    LinkBodyPreview(link: link)
            }.listRowSeparator(.hidden).padding(0)
            
            WykopColors.shared.currentTheme.backgroundColor.frame( height: 30, alignment: .center).listRowInsets(EdgeInsets()).listRowSeparator(.hidden)
            
            
            Tabs(tabs: .constant(LinkDetailsTabs.allCases.map({ tab in
                tab.rawValue
            })),
                 selection: $selected,
                 underlineColor: .black) { title, isSelected in
                Text(title.uppercased())
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                    .foregroundColor(isSelected ? .black : .gray)
            }
            
            
            switch self.selectedTab() {
            case .Comments:
                
                VStack(alignment: .leading) {
                    LinkWithCommentsView(link: link)
                }
                
            case .VotersUp:
                VStack(alignment: .leading) {
                    LinkWithVoters()
                }
                
            case .VotersDown:
                Text("TODO")
            case .Attachments:
                Text("TODO")
            case .Tags:
                Text("TODO")
            }
            
            
        }.listStyle(PlainListStyle()).refreshable {
            self.reloadLink();
        }.onAppear(){
            self.reloadLink();
        }
        
        
    }
}


struct LinkWithCommentsView: View {
    var link:Link
    
    var body: some View {
        
        
        Section {
            
            ForEach(link.comments ?? [], id: \.id) { item in
                
                if (!item.isResponseComment()) {
                    WykopColors.shared.currentTheme.backgroundColor.frame( height: 10, alignment: .center).listRowInsets(EdgeInsets()).listRowSeparator(.hidden)
                }
                
                VStack(alignment: .leading) {
                    AuthorWithDateHeader(author: item.author, date: item.getDate(), voteCount: item.voteCount)
                    Text(item.bodyAttributed ?? "").fixedSize(horizontal: false, vertical: true)
                    if let embed = item.embed {
                        EmbedViewModel(embed: embed).prepareView().onTapGesture {
                            BasePushableViewModel.navigation?.presentFullScreen(EmbedViewModel(embed: embed).prepareModalView())
                        }
                    }
                    
                }.listRowSeparator(.hidden).padding(.leading,                                                   (item.isResponseComment() ? 30.0 : 0.0))
                
                
                
            }
        }
        
        
    }
}

struct LinkWithVoters: View {
    //    var voters:[Author]
    
    var body: some View {
        
        
        List {
            
            ForEach(["TODO11","TODO1","TODO2","TODO4","TODO3"], id: \.hashValue) { item in
                VStack(alignment: .leading) {
                    Text(item)
                    
                }.listRowSeparator(.hidden)
                
            }
        }
        
        
    }
}


struct LinkViewCellHeader : View
{
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @Environment(\.openURL) var openInExternalSafari
    
    var link: Link;
    
    var body: some View {
        VStack(alignment: .leading){
            
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
                    LinkHeader(link: link, displayDescription: true)
                    
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
            
        }.padding(0)
            
//            .onTapGesture {
//            
//            openInExternalSafari(URL(string: link.sourceUrl)!)
//            
//        }
        
        
        
    }
    
}
