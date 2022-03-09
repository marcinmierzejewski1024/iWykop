//
//  EntryDetailsView.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 20/02/2022.
//

import SwiftUI

struct EntryDetailsView: View {
    @State var entry : Entry;
    @ObservedObject var viewModel : EntriesViewModel;
    
    func reloadEntry() {
        Task {
            
            if let new = await viewModel.refreshEntry(entry) {
                entry = new;
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            EntryWithCommentsView(entry: entry)
        }.listStyle(PlainListStyle()).refreshable {
            self.reloadEntry();
        }.onAppear(){
            self.reloadEntry();
        }
        
        
        
    }
}


struct EntryWithCommentsView: View {
    var entry:Entry
    
    var body: some View {
        List() {
            Section {
                
                VStack (alignment: .leading){
                    EntryViewCellHeader(entry: entry)
                    EntryBodyPreview(entry: entry)
                    //                Text("Comments:").font(.title).padding()
                }.listRowSeparator(.hidden)
            }
            
            WykopColors.backgroundColor.frame( height: 30, alignment: .center).listRowInsets(EdgeInsets()).listRowSeparator(.hidden)
            
            Section {
                
                ForEach(entry.comments ?? [], id: \.id) { item in
                    VStack(alignment: .leading) {
                        AuthorView(author: item.author)
                        Text(item.bodyAttributed ?? "").fixedSize(horizontal: false, vertical: true)
                        EmbedBodyPreviewWithModal(embed: item.embed)
                        HStack{
                            Spacer()
                            Text("+\(item.voteCount)").foregroundColor(Color.green)
                        }
                        
                    }.listRowSeparator(.hidden)
                    WykopColors.backgroundColor.frame( height: 10, alignment: .center).listRowInsets(EdgeInsets()).listRowSeparator(.hidden)
                    
                }
            }
            
        }
    }
}
//struct EntryDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        EntryDetailsView()
//    }
//}
