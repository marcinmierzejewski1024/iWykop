//
//  EntryDetailsView.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 20/02/2022.
//

import SwiftUI
import KSToastView

struct EntryDetailsView: View {
    @State var entry : Entry;
    @ObservedObject var viewModel : EntryViewModel;
    
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
    var embedViewModel : EmbedViewModel?;
    
    var body: some View {
        List() {
            Section {
                
                VStack (alignment: .leading){
                    EntryViewCellHeader(entry: entry)
                    EntryBodyPreview(entry: entry)
                    //                Text("Comments:").font(.title).padding()
                }.listRowSeparator(.hidden)
            }
            
            WykopColors.currentTheme.backgroundColor.frame( height: 30, alignment: .center).listRowInsets(EdgeInsets()).listRowSeparator(.hidden)
            
            Section {
                
                ForEach(entry.comments ?? [], id: \.id) { item in
                    
                    CommentViewModel(comment: item).prepareView()
                    WykopColors.currentTheme.backgroundColor.frame( height: 10, alignment: .center).listRowInsets(EdgeInsets()).listRowSeparator(.hidden)
                    
                }
            }
            
        }
    }
}

struct CommentView: View {
    var viewModel: CommentViewModel;
    
    var body: some View {
        VStack(alignment: .leading) {
            AuthorWithDateHeader(author: viewModel.comment.author, date: viewModel.comment.getDate())
            Text(viewModel.comment.bodyAttributed ?? "").fixedSize(horizontal: false, vertical: true)
            if let embed = self.viewModel.comment.embed {
                EmbedBodyPreviewWithModal(viewModel:EmbedViewModel(embed: embed))
            }
            HStack{
                Spacer()
                Text("+\(viewModel.comment.voteCount)").modifier(BodyStyle()).foregroundColor(WykopColors.currentTheme.plusGreenColor)
            }
            
        }.listRowSeparator(.hidden)

    }
}


