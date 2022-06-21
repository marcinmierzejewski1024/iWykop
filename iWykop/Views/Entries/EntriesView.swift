//
//  EntriesView.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 18/02/2022.
//

import SwiftUI
import KSToastView
import AxisSegmentedView

struct EntriesView: View {
    @ObservedObject var entriesVM : EntriesViewModel;
    @State var selectedPeriod = 6;
    @ViewBuilder
    var body: some View {
        
        
        
        VStack(alignment: .center) {
            
            AxisSegmentedView(selection: $selectedPeriod, constant: .init()) {
                Text("6h").font(.title3).foregroundColor(.accentColor)
                    .itemTag(6, selectArea: 0) {
                        Text("6h").font(.title3).bold()
                        
                    }
                Text("12h").font(.title3).foregroundColor(.accentColor)
                
                    .itemTag(12, selectArea: 0) {
                        Text("12h").font(.title3).bold()
                    }
                Text("24h").font(.title3).foregroundColor(.accentColor)
                
                    .itemTag(24, selectArea: 0) {
                        Text("24h").font(.title3).bold()
                    }
            } style: {
                ASScaleStyle(backgroundColor: .clear, foregroundColor: WykopColors.shared.currentTheme.accentColor.opacity(0.4))
                
            } onTapReceive: { selectionTap in
                Task {
                    let period = EntriesPeriod.fromRaw(rawValue: selectionTap)!
                    await entriesVM.changeRequestedPeriod(period: period);
                }
                
            }
            .frame(width: 280, height: 40).padding(.bottom, Margins.medium.rawValue)
            
            EntriesListView(entriesVM: self.entriesVM)
            
        }
        
        
        
    }
    
    
    struct EntriesListView: View {
        
        @ObservedObject var entriesVM : EntriesViewModel;
        
        
        @ViewBuilder
        var body: some View {
            
            
            List() {
                
                ForEach(entriesVM.entries, id: \.id) { item in
                    
                    
                    ZStack {
                        
                        if (item.hasAdultContent() == false || entriesVM.settingsStore.plus18Enabled ) {
                            
                            EntryViewCell(entry: item).onAppear {
                                if item == self.entriesVM.entries.last {
                                    Task {
                                        await self.entriesVM.getNextEntries()
                                    }
                                }
                                
                                
                            }.onTapGesture {
                                BasePushableViewModel.navigation?.pushView(EntryViewModel(entry: item).prepareView())
                                
                            }
                        }
                        
                        
                    }.listRowBackground(WykopColors.shared.currentTheme.backgroundColor.ignoresSafeArea()).listRowInsets(EdgeInsets()).listRowSeparator(.hidden).padding(.bottom, Margins.medium.rawValue)
                    
                    
                    
                }
            }.listStyle(PlainListStyle()).refreshable {
                Task {
                    
                    await self.entriesVM.refreshEntries()
                }
            }
            
            
            
        }
    }
    
}

struct EntryViewCell: View {
    @State var entry: Entry;
    
    
    var body: some View {
        ZStack{
            
            VStack(alignment: .leading) {
                EntryViewCellHeader(entry: entry)
                EntryBodyPreview(entry: entry)
                
                HStack {
                    Spacer()
                    Image(systemName:"text.bubble").modifier(BodyStyle())
                    Text("\(entry.commentsCount)")
                }
            }
            
        }.padding(.horizontal, Margins.medium.rawValue).padding(.vertical, Margins.medium.rawValue).modifier(CardStyle())
        
        
    }
    
}

struct EntryViewCellHeader : View
{
    
    var entry: Entry;
    
    var body: some View {
        HStack{
            
            AuthorWithDateHeader(author: entry.author, date: entry.getDate(), voteCount: entry.voteCount)
            
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
            if let embed = entry.embed {
                
                self.generatedViewModel?.prepareView().onTapGesture {
                    BasePushableViewModel.navigation?.presentFullScreen(EmbedViewModel(embed: embed).prepareModalView())
                }
                
            }
            
        }.padding(0).onAppear {
            self.prepareViewModel();
        }
        
    }
}



