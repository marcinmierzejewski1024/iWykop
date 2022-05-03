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
    @ObservedObject var viewModel : EntriesViewModel;
    @State var selection = 0;
    @ViewBuilder
    var body: some View {
        
        
        
        VStack(alignment: .center) {
            
            AxisSegmentedView(selection: $selection, constant: .init()) {
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
                ASScaleStyle(backgroundColor: WykopColors.shared.currentTheme.cardColor, foregroundColor: WykopColors.shared.currentTheme.accentColor.opacity(0.4))
                //                ASBasicStyle(backgroundColor: WykopColors.shared.currentTheme.cardColor, foregroundColor: WykopColors.shared.currentTheme.accentColor)
                
            } onTapReceive: { selectionTap in
                Task {
                    let period = EntriesPeriod.fromRaw(rawValue: selectionTap)!
                    await viewModel.changeRequestedPeriod(period: period);
                }
                
            }
            .frame(width: 280, height: 44)
            
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
                        
                        
                    }.listRowBackground(WykopColors.shared.currentTheme.backgroundColor.ignoresSafeArea()).listRowInsets(EdgeInsets()).listRowSeparator(.hidden).padding(.bottom, Margins.medium.rawValue)
                    
                    
                    
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
        ZStack{
            
            VStack(alignment: .leading) {
                EntryViewCellHeader(entry: entry)
                EntryBodyPreview(entry: entry)
                
                HStack {
                    Spacer()
                    
                    Text("+\(entry.voteCount)").foregroundColor(WykopColors.shared.currentTheme.plusGreenColor).padding(.trailing, Margins.medium.rawValue)
                    Image(systemName:"text.bubble").modifier(BodyStyle())
                    Text("\(entry.commentsCount)")
                }
            }
            
        }.modifier(CardStyle()).padding(0)
        
        
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



