//
//  SearchView.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 01/03/2022.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = "";

    var body: some View {
        NavigationView {
            Text("Searching for \(searchText)").modifier(OtherTextStyle())
                .searchable(text: $searchText, prompt: "Look for something").modifier(OtherTextStyle())
                .navigationTitle("Search")
        }.modifier(BackgroundStyle())
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
