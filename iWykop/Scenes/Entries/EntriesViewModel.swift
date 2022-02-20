//
//  EntriesViewModel.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 18/02/2022.
//

import Foundation
import Resolver
import OrderedCollections

class EntriesViewModel : Resolving, ObservableObject
{
    lazy var entriesService: EntriesService = resolver.resolve()
    lazy var entryService: EntryService = resolver.resolve()

    @Published var entries = OrderedSet<Entry>();
    private var lastDownloadedPage = 1;

    @Published var currentEntry :Entry?;

    
    func getNextEntries() async {
        await self.getEntries(page: self.lastDownloadedPage + 1);
    }
    
    func getEntries(page : Int = 1) async {
            do {
                let newEntries = try await entriesService.getEntries(page: page);
            
                DispatchQueue.main.async {
                    
                    self.entries.append(contentsOf: newEntries);
                    self.lastDownloadedPage = page;
                    
                }
                
            } catch {
            }
    }
    
    func selectEntry(_ entry:Entry) {
        self.currentEntry = entry;
        Task {
            
            let fullEntry = try await self.entryService.getEntry(id: self.currentEntry!.id);
            
            DispatchQueue.main.async {
                self.currentEntry = fullEntry;
            }
        }
    }
    
    func addButtonClicked() {
        
    }
    
}


class MockEntriesViewModel : EntriesViewModel
{
    override init() {
        super.init();
        
        let author = Author(avatar: "", login: "smaleckg", sex: .male, background: "", signupAt: "", color: 1);
        let entry = Entry(id:123, body: "wpis", favorite: false, userVote: 3, blocked: false, author: author, original: "", embed: nil, url: "www.wykop.pl", date: "11.12.2012", voteCount: 124, commentsCount: 44, status: .visible, app: "lurker",comments: nil)
        let entry2 = Entry(id:1243, body: "wpis drugi 123123", favorite: false, userVote: 3, blocked: false, author: author, original: "", embed: nil, url: "www.wykop.pl", date: "11.12.2012", voteCount: 124, commentsCount: 44, status: .visible, app: "lurker v2",comments: [])

        self.entries = [entry,entry2];
        
    }
}
