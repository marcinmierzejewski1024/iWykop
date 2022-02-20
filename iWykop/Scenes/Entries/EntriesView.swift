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
        
        let title = "Mikroblog";
        
        NavigationView {
            
            if(viewModel.currentEntry != nil) {
                EntryDetailsView(entry: viewModel.currentEntry!)
            } else {
                EntriesListView(viewModel: self.viewModel)
                
            }
        }
        .navigationTitle(title)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Back") {
                    viewModel.selectEntry(nil);
                }
            }
        }
    }
    
    
    struct EntriesListView: View {
        
        @ObservedObject var viewModel : EntriesViewModel;
        
        
        @ViewBuilder
        var body: some View {
            
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
                EmbedBodyPreviewWithModal(embed: entry.embed!)
            }
            
        }.padding(0)
        
    }
}


struct EmbedBodyPreviewWithModal : View {
    
    var embed: Embed?;
    @State private var isPresented = false
    @State private var offset = CGSize.zero

    
    
    var body: some View {
        HStack{
            if let embed = embed {
                
                EmbedBodyPreview(embed: embed).onTapGesture {
                    self.isPresented.toggle()
                }
                .fullScreenCover(isPresented: $isPresented, content: {
                    EmbedBodyPreview(embed: embed).offset(x: offset.width * 0.7, y: offset.height * 0.7)

                        .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .global).onChanged({ value in

                            offset = value.translation


                        }).onEnded { value in
                            let horizontalAmount = value.translation.width as CGFloat
                            let verticalAmount = value.translation.height as CGFloat
                            
                            if abs(horizontalAmount) > 80 || abs(verticalAmount) > 80 {
                                withAnimation {
                                    isPresented.toggle();
                                }
                            }

                            withAnimation {
                                offset = CGSize.zero;
                            }
                        })
                    
                })
            }
            
        }.padding(0)
        
    }
    
}


struct EmbedBodyPreview : View {
    var embed: Embed;
    
    var body: some View {
        HStack{
            if(embed.type == .image) {
                AsyncImage(
                    url: URL(string:embed.url),
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(minWidth : 270,maxWidth: 280,
                                   minHeight: 270, maxHeight: 380)
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
                
            }
            if(embed.type == .video){
                UIWKWebview(url: embed.url)
            }
            
        }
        
    }
}

//struct EntriesView_Previews: PreviewProvider {
//    static var previews: some View {
//        EntriesView(viewModel: MockEntriesViewModel())
//    }
//}
