//
//  EntriesViewModel.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 18/02/2022.
//

import Foundation
import Resolver

class EntriesViewModel : Resolving, ObservableObject
{
    lazy var entriesService: EntriesService = resolver.resolve()
    @Published var entries :[Entry]?;
    @Published var currentEntry :Entry?;

    
    func getEntries() {
        Task {
            do {
            entries = try await entriesService.getEntries();
            } catch {
//                entries
            }
        }
    }
    
    func selectEntry(_ entry:Entry) {
        self.currentEntry = entry;
    }
    
    func addButtonClicked() {
        
    }
    
}


class MockEntriesViewModel : EntriesViewModel
{
    override init() {
        super.init();
        let author = User(login: "smaleckg", color: 1, sex: .male, avatar: "https://www.wykop.pl/cdn/c3397992/smaleckg_JGAFgGehNY,q48.jpg")
        self.entries = [Entry(id: "2342", date: Date(), body: "Tresc wpisu lorem ipsum", author: author, blocked: nil, favorite: nil, vote_count: 2, comments_count: 14),Entry(id: "243342", date: Date(), body: "2222 Tresc wpisu lorem ipsum", author: author, blocked: nil, favorite: nil, vote_count: 5, comments_count: 1)];
    }
}
