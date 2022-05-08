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
    @ObservedObject var entryVM : EntryViewModel;
    
    func reloadEntry() {
        
        Task {
            if let new = await entryVM.refreshEntry(entry) {
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
            
            
            Section {
                
                ForEach(entry.comments ?? [], id: \.id) { item in
                    
                    CommentViewModel(comment: item).prepareView().listRowBackground(WykopColors.shared.currentTheme.cardColor.ignoresSafeArea())

                    
                }
            }
            
        }
    }
}

struct CommentView: View {
    @State var commentVM: CommentViewModel;
    
    var body: some View {
        VStack(alignment: .leading) {
            AuthorWithDateHeader(author: commentVM.comment.author, date: commentVM.comment.getDate(), voteCount: commentVM.comment.voteCount)
            Text(commentVM.comment.bodyAttributed ?? "").fixedSize(horizontal: false, vertical: true)
            if let embed = self.commentVM.comment.embed {
                EmbedViewModel(embed: embed).prepareView().onTapGesture {
                    
                    BasePushableViewModel.navigation?.presentFullScreen(EmbedViewModel(embed: embed).prepareModalView())
                }
            }
            
        }.listRowSeparator(.hidden)

    }
}


