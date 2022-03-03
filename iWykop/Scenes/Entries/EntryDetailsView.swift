//
//  EntryDetailsView.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 20/02/2022.
//

import SwiftUI

struct EntryDetailsView: View {
    @ObservedObject var viewModel : EntriesViewModel;

    var body: some View {
        VStack(alignment: .leading) {
            if let entry = viewModel.currentEntry {
                EntryCommentsView(entry: entry)
            }
            
        }.refreshable {
            task {
                await viewModel.refreshEntry()
            }
        }
    }
}


struct EntryCommentsView: View {
    var entry:Entry
    
    var body: some View {
        List() {
            VStack (alignment: .leading){
                EntryViewCellHeader(entry: entry)
                EntryBodyPreview(entry: entry).padding()
//                Text("Comments:").font(.title).padding()
            }
            Spacer(minLength: 50)
            
            ForEach(entry.comments ?? [], id: \.id) { item in
                VStack(alignment: .leading) {
                    AuthorView(author: item.author)
                    Text(item.body?.markupFromHtml ?? "")
                    EmbedBodyPreviewWithModal(embed: item.embed)
                    HStack{
                        Spacer()
                        Text("+\(item.voteCount)").foregroundColor(Color.green)
                    }.padding(10)
                    
                }.padding(10)
            }
            
        }
    }
}
    //struct EntryDetailsView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        EntryDetailsView()
    //    }
    //}
