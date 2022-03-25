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
    @ObservedObject var viewModel : LinkViewModel;
    
    func selectedTab() -> LinkDetailsTabs {
        return LinkDetailsTabs.allCases[selected];
    }
    
    func reloadLink() {
        
        Task {
            if let new = await viewModel.refreshLink(link) {
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
            
            WykopColors.currentTheme.backgroundColor.frame( height: 30, alignment: .center).listRowInsets(EdgeInsets()).listRowSeparator(.hidden)
            
            
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
        }.onOpenURL { url in
            Task {
                await self.viewModel.presentFromUrl(url)
            }
        }
        
        
    }
}


struct LinkWithCommentsView: View {
    var link:Link
    
    var body: some View {
        
        
        Section {
            
            ForEach(link.comments ?? [], id: \.id) { item in
                VStack(alignment: .leading) {
                    AuthorWithDateHeader(author: item.author, date: item.getDate())
                    Text(item.bodyAttributed ?? "").fixedSize(horizontal: false, vertical: true)
                    EmbedBodyPreviewWithModal(embed: item.embed)
                    HStack{
                        Spacer()
                        Text("+\(item.voteCount)").modifier(BodyStyle()).foregroundColor(WykopColors.currentTheme.plusGreenColor)
                    }
                    
                }.listRowSeparator(.hidden)
                WykopColors.currentTheme.backgroundColor.frame( height: 10, alignment: .center).listRowInsets(EdgeInsets()).listRowSeparator(.hidden)
                
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
    
    var link: Link;
    
    var body: some View {
        VStack{
            CacheAsyncImage(
                url: URL(string:link.getFullPreviewImageURL() ?? "")){ phase in
                    switch phase {
                    case .success(let image):
                        VStack(alignment: .center) {
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    case .failure(let error):
                        Text(error.localizedDescription)
                        
                    default:
                        Image("placeholder").modifier(BodyStyle())
                        
                    }
                }.padding(0)
            Text(link.description ?? "").padding(10).fixedSize(horizontal: false, vertical: true).modifier(BodyStyle())
            
        }.padding(0)
        
        
        
    }
    
}
