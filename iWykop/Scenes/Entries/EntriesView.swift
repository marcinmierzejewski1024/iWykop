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
            List() {
                
                ForEach(viewModel.entries ?? [], id: \.id) { item in
                    EntryViewCell(entry: item).onTapGesture {
                        viewModel.selectEntry(item);
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

struct EntryViewCell: View {
    var entry: Entry;
    
    
    var body: some View {
        HStack{
            Spacer()
            VStack(alignment: .trailing) {
                EntryViewCellHeader(entry: entry)
                Text(entry.body)
                
                
            }.frame( alignment: .trailing)
            
        }.padding(0)
        
    }
    
}

struct EntryViewCellHeader : View
{
    
    var entry: Entry;
    
    var body: some View {
        HStack{
//            Text("comments: \(entry.comments_count)").bold()

            Text(entry.author.login).bold()
            
        }.padding(0)
        
        
        
    }
    
}
    
    struct EntriesView_Previews: PreviewProvider {
        static var previews: some View {
            EntriesView(viewModel: MockEntriesViewModel())
        }
    }
