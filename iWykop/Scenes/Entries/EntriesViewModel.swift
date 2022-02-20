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

    
    func getEntries() async {
            do {
            let newEntries = try await entriesService.getEntries();
            
                DispatchQueue.main.async {
                    for entry in newEntries {
                        if let orginal = entry.original {
                            print(orginal);
                        }
                    }
                    self.entries = newEntries;
                    
                    
                }
                
            } catch {
//                entries
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
        
        let author = Author(avatar: "", login: "smaleckg", sex: .male, background: "", signupAt: "", color: 1);
        let entry = Entry(id:123, body: "wpis", favorite: false, userVote: 3, blocked: false, author: author, original: "", embed: nil, url: "www.wykop.pl", date: "11.12.2012", voteCount: 124, commentsCount: 44, status: .visible, app: "lurker")
        let entry2 = Entry(id:1243, body: "wpis drugi 123123", favorite: false, userVote: 3, blocked: false, author: author, original: "", embed: nil, url: "www.wykop.pl", date: "11.12.2012", voteCount: 124, commentsCount: 44, status: .visible, app: "lurker v2")

        self.entries = [entry,entry2];
        
    }
}
