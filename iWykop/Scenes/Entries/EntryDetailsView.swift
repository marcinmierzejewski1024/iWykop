//
//  EntryDetailsView.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 20/02/2022.
//

import SwiftUI

struct EntryDetailsView: View {
    var entry:Entry
    
    var body: some View {
        VStack {
            EntryCommentsView(entry: entry)
            
        }
    }
}


struct EntryCommentsView: View {
    var entry:Entry
    
    var body: some View {
        List() {
            EntryViewCellHeader(entry: entry)
            EntryBodyPreview(entry: entry)

            Text("Comments:").font(.title2)
            ForEach(entry.comments ?? [], id: \.id) { item in
                Text(item.original ?? "")
                Text(item.author.login).bold()
                
            }
            
        }
    }
}
    //struct EntryDetailsView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        EntryDetailsView()
    //    }
    //}
