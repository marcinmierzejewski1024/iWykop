//
//  EntryDetailsView.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 20/02/2022.
//

import SwiftUI
import KSToastView

struct EntryDetailsView: View {
    @ObservedObject var entryVM : EntryViewModel;
    
    func reloadEntry() {
        
        Task {
            await entryVM.refreshEntry(entryVM.entry)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            EntryWithCommentsView(entry: entryVM.entry)
            
        }.listStyle(PlainListStyle()).refreshable {
            self.reloadEntry();
        }.onAppear(){
            self.reloadEntry();
        }.navigationBarTitle(configuration: .init(title: "", displayMode: .inline))
        
        
        
    }
}


struct EntryWithCommentsView: View {
    @EnvironmentObject var theme : WykopColors

    var entry:Entry
    var embedViewModel : EmbedViewModel?;
    
    var body: some View {
        List() {
            Section {
                
                VStack (alignment: .leading){
                    EntryViewCellHeader(entry: entry)
                    EntryBodyPreview(entry: entry)
                    //                Text("Comments:").font(.title).padding()
                }.listRowSeparator(.hidden).padding(.bottom, Margins.huge.rawValue)
            }
            
            
            Section {
                if let comments = entry.comments {
                    
                    ForEach(comments, id: \.id) { item in
                        
                        CommentViewModel(comment: item).prepareView().listRowBackground(theme.currentTheme.cardColor.ignoresSafeArea())
                        
                        
                    }
                } else {
                    
                    LoadingView(title: "Loading comments");
                    
                }
                
            }
            
        }
    }
}

struct CommentView: View {
    @State var commentVM: CommentViewModel;
    
    var body: some View {
        VStack(alignment: .leading) {
            AuthorWithDateHeader(author: commentVM.comment.author, date: commentVM.comment.date, voteCount: VoteCount.from(comment: commentVM.comment))
            Text(commentVM.comment.bodyAttributed ?? "").fixedSize(horizontal: false, vertical: true)
            if let embed = self.commentVM.comment.embed {
                EmbedViewModel(embed: embed).prepareView().onTapGesture {
                    BasePushableViewModel.navigation?.presentFullScreen(EmbedViewModel(embed: embed).prepareModalView())
                }
            }
            
        }.listRowSeparator(.hidden)
        
    }
}


