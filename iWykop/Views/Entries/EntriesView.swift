//
//  EntriesView.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 18/02/2022.
//

import SwiftUI

struct EntriesView: View {
    @ObservedObject var viewModel : EntriesViewModel;
    
    @ViewBuilder
    var body: some View {
        
            
            VStack {
                NavigationLink(destination: self.viewModel.childView(), isActive: $viewModel.childViewActive) { EmptyView() }.hidden()

                DisclosureGroup("\(viewModel.requestedPeriod.rawValue)h") {
                    Text("6h").font(.headline).padding(5).onTapGesture {
                        Task {
                            await viewModel.changeRequestedPeriod(period: .from6);
                        }
                    }
                    Text("12h").font(.headline).padding(5).onTapGesture {
                        Task {
                            
                            await viewModel.changeRequestedPeriod(period: .from12);
                        }
                    }
                    Text("24h").font(.headline).padding(5).onTapGesture {
                        Task {
                            
                            await viewModel.changeRequestedPeriod(period: .from24);
                        }
                    }
                }.padding(.horizontal, 20).padding(.vertical, 10).font(.title)
                
                EntriesListView(viewModel: self.viewModel)
                
            }
            
            
        
    }
    
    
    struct EntriesListView: View {
        
        @ObservedObject var viewModel : EntriesViewModel;
        
        
        @ViewBuilder
        var body: some View {
            
            
            List() {
                
                ForEach(viewModel.entries, id: \.id) { item in
                    
                    
                    ZStack {
                        
                        
                        EntryViewCell(entry: item).onAppear {
                            if item == self.viewModel.entries.last {
                                Task {
                                    await self.viewModel.getNextEntries()
                                }
                            }
                        }.onTapGesture {
                            self.viewModel.presentChildViewModel(EntryViewModel(entry: item))
                        }
                        
                        
                    }
                    
                    
                    
                    WykopColors.currentTheme.backgroundColor.frame( height: 20, alignment: .center).listRowInsets(EdgeInsets()).listRowSeparator(.hidden)
                    
                    
                    
                }
            }.listStyle(PlainListStyle()).refreshable {
                Task {
                    
                    await self.viewModel.refreshEntries()
                }
            }.onOpenURL { url in
                Task {
                    await self.viewModel.presentFromUrl(url)
                }
            }
            
            
            
        }
    }
    
}

struct EntryViewCell: View {
    var entry: Entry;
    
    
    var body: some View {
        HStack{
            Spacer()
            VStack(alignment: .leading) {
                EntryViewCellHeader(entry: entry)
                EntryBodyPreview(entry: entry)
                
                HStack {
                    Spacer()
                    
                    Text("+\(entry.voteCount)").foregroundColor(Color.green).padding(.trailing, 5)
                    Image(systemName:"text.bubble").modifier(BodyStyle())
                    Text("\(entry.commentsCount)")
                }
            }
            
        }.padding(0).modifier(CardStyle())
        
        
    }
    
}

struct EntryViewCellHeader : View
{
    
    var entry: Entry;
    
    var body: some View {
        HStack{
            
            AuthorWithDateHeader(author: entry.author, date: entry.getDate())
            
        }.padding(0)
        
        
        
    }
    
}


struct EntryBodyPreview : View
{
    var entry: Entry;
    
    
    var body: some View {
        VStack{
            //            Text(entry.body ?? "")
            
            Text(entry.bodyAttributed ?? "").fixedSize(horizontal: false, vertical: true)
            if(entry.embed != nil && entry.embed?.plus18 == false) {
                EmbedBodyPreviewWithModal(embed: entry.embed!)
            }
            
        }.padding(0)
        
    }
}



