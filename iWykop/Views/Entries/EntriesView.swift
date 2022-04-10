//
//  EntriesView.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 18/02/2022.
//

import SwiftUI
import KSToastView

struct EntriesView: View {
    @ObservedObject var viewModel : EntriesViewModel;
    
    @ViewBuilder
    var body: some View {
        
        
        
        VStack {
            
            DisclosureGroup("\(viewModel.requestedPeriod.rawValue)h") {
                Text("6h").font(.headline).padding(Margins.medium.rawValue).onTapGesture {
                    Task {
                        await viewModel.changeRequestedPeriod(period: .from6);
                    }
                }
                Text("12h").font(.headline).padding(Margins.medium.rawValue).onTapGesture {
                    Task {
                        
                        await viewModel.changeRequestedPeriod(period: .from12);
                    }
                }
                Text("24h").font(.headline).padding(Margins.medium.rawValue).onTapGesture {
                    Task {
                        
                        await viewModel.changeRequestedPeriod(period: .from24);
                    }
                }
            }.padding(.horizontal, Margins.huge.rawValue).padding(.vertical, Margins.huge.rawValue).font(.title)
            
            EntriesListView(viewModel: self.viewModel)
            
        }
        
        
        
    }
    
    
    struct EntriesListView: View {
        @EnvironmentObject var settings: SettingsStore
        
        @ObservedObject var viewModel : EntriesViewModel;
        
        
        @ViewBuilder
        var body: some View {
            
            
            List() {
                
                ForEach(viewModel.entries, id: \.id) { item in
                    
                    
                    ZStack {
                        
                        if (item.hasAdultContent() == false || settings.plus18Enabled ) {
                            
                            EntryViewCell(entry: item).onAppear {
                                if item == self.viewModel.entries.last {
                                    Task {
                                        await self.viewModel.getNextEntries()
                                    }
                                }
                                
                                
                            }.onTapGesture {
                                BasePushableViewModel.navigation?.pushView(EntryViewModel(entry: item).prepareView())
                                
                            }
                        }
                        
                        
                    }.listRowBackground(WykopColors.currentTheme.backgroundColor.ignoresSafeArea())
                    
                    
                    
                }
            }.listStyle(PlainListStyle()).refreshable {
                Task {
                    
                    await self.viewModel.refreshEntries()
                }
            }
            
            
            
        }
    }
    
}

struct EntryViewCell: View {
    @State var entry: Entry;
    
    
    var body: some View {
        HStack{
            Spacer()
            VStack(alignment: .leading) {
                EntryViewCellHeader(entry: entry)
                EntryBodyPreview(entry: entry)
                
                HStack {
                    Spacer()
                    
                    Text("+\(entry.voteCount)").foregroundColor(Color.green).padding(.trailing, Margins.medium.rawValue)
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
    @State var generatedViewModel : EmbedViewModel?;
    
    func prepareViewModel() {
        print("preparing view model!")
        if let embed = entry.embed {
            if(self.generatedViewModel == nil) {
                self.generatedViewModel = EmbedViewModel(embed: embed);
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(entry.bodyAttributed ?? "").fixedSize(horizontal: false, vertical: true)
            if(entry.embed != nil) {
                self.generatedViewModel?.prepareView()
            }
            
        }.padding(0).onAppear {
            self.prepareViewModel();
        }
        
    }
}



