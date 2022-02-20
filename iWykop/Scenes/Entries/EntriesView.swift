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
        
        if(viewModel.currentEntry != nil) {
            EntryDetailsView(entry: viewModel.currentEntry!)
        } else {
            EntriesListView(viewModel: self.viewModel)

        }
    }
    
    
    struct EntriesListView: View {
        
        @ObservedObject var viewModel : EntriesViewModel;

        
        @ViewBuilder
        var body: some View {
            
            let title = "Mikroblog";

            NavigationView {
                List() {
                    ForEach(viewModel.entries, id: \.id) { item in
                        EntryViewCell(entry: item).onTapGesture {
                            viewModel.selectEntry(item)
                        }.onAppear {
                            if item == self.viewModel.entries.last {
                                Task {
                                    await self.viewModel.getNextEntries()
                                }
                            }
                        }
                    }
                }.padding(0)
                
                
                    .navigationTitle(title)
                    .toolbar {
                        //                    ToolbarItem(placement: .navigationBarTrailing) {
                        //                        Button("Add") {
                        //                            viewModel.addButtonClicked()
                        //                        }
                        //                    }
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
            VStack(alignment: .trailing) {
                EntryViewCellHeader(entry: entry)
                EntryBodyPreview(entry: entry)
            }.frame( alignment: .trailing)
            
        }.padding(0)
        
    }
    
}

struct EntryViewCellHeader : View
{
    
    var entry: Entry;
    
    var body: some View {
        HStack{
            Text("comments: \(entry.commentsCount)")
            Spacer()
            Text(entry.author.login).bold()
            
        }.padding(0)
        
        
        
    }
    
}


struct EntryBodyPreview : View
{
    var entry: Entry;
    
    
    var body: some View {
        VStack{
            Text(entry.original ?? "")
            if(entry.embed != nil && entry.embed?.plus18 == false) {
                EmbedBodyPreview(embed: entry.embed!)
            }
            
        }.padding(0)
        
    }
}


struct EmbedBodyPreview : View {
    
    var embed: Embed?;
    @State private var isPresented = false
    
    
    
    var body: some View {
        HStack{
            AsyncImage(
                url: URL(string:embed!.url),
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth : 70,maxWidth: 280,
                               minHeight: 70, maxHeight: 380)
                },
                placeholder: {
                    ProgressView()
                }
            ).onTapGesture{
                self.isPresented.toggle()
            }
            .fullScreenCover(isPresented: $isPresented, content: {
                
                AsyncImage(
                    url: URL(string:embed!.url),
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(minWidth : 70,maxWidth: 480,
                                   minHeight: 70, maxHeight: 480)
                    },
                    placeholder: {
                        ProgressView()
                    }
                ).onTapGesture {
                    self.isPresented.toggle()
                    
                }
                
            })
            
            
        }.padding(0)
        
    }
    
}

struct EntriesView_Previews: PreviewProvider {
    static var previews: some View {
        EntriesView(viewModel: MockEntriesViewModel())
    }
}
