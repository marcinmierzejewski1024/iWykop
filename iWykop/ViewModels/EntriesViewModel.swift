//
//  EntriesViewModel.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 18/02/2022.
//

import Foundation
import Resolver
import OrderedCollections
import KSToastView
import SwiftUI

class EntriesViewModel : BasePushableViewModel
{
        
    lazy var entriesService: EntriesService = resolver.resolve()
    
    @Published var entries = [Entry]();
    private var lastDownloadedPage = 1;
    
    @Published var requestedPeriod = EntriesPeriod.from6;
    
    
    
    func getNextEntries() async {
        await self.getEntries(page: self.lastDownloadedPage + 1);
    }
    
    func refreshEntries() async {
        
        do {
            var newEntries = try await entriesService.getEntries(page: 1,period: self.requestedPeriod);
            newEntries = await self.withAttributedBody(newEntries);
            
            self.entries.removeAll()
            self.entries.append(contentsOf: newEntries);
            self.lastDownloadedPage = 1;
            
            
        } catch {
            print(error);
            DispatchQueue.main.async {
                KSToastView.ks_showToast(error.localizedDescription);
            }
            
        }
    }
    
    func changeRequestedPeriod(period:EntriesPeriod) async {
        self.requestedPeriod = period;
        await self.refreshEntries()
    }
    
    
    
    func getEntries(page : Int = 1) async {
        do {
            var newEntries = try await entriesService.getEntries(page: page, period:self.requestedPeriod);
            newEntries = await self.withAttributedBody(newEntries);
            
            self.entries.append(contentsOf: newEntries);
            self.lastDownloadedPage = page;
            
            self.imagesPreload()
            
        } catch {
            print(error);
            DispatchQueue.main.async {
                KSToastView.ks_showToast(error.localizedDescription);
            }
            
        }
    }
    
    func withAttributedBody(_ entries:[Entry]) async -> [Entry] {
        let withAttributedBody = await bodyFormatter.addBodyAttr(es: entries)
        
        return withAttributedBody as? [Entry] ?? [];
        
    }
    
    
    func imagesPreload(){
        self.entries.forEach { entry in
            if(entry.embed?.type == .image){
                ImageCache.sharedInstance.preloadImage(url: entry.embed?.preview);
            }
        }
    }
    
    override func prepareView() -> AnyView {
        return AnyView(EntriesView(entriesVM: self).onOpenURL(perform: { url in
            self.handle(url: url)
        }).task {
            await self.getEntries();
        });
    }
    
    
    override func handle(url: URL){
        
        if(url.absoluteString.contains("iwykop:spoiler:")) {
        
            let entryWithThisSpoiler = entries.first(where: { candidate in
                let body = candidate.body;
                let needle = url.absoluteString.replacingOccurrences(of: "iwykop:spoiler:", with: "")
                return body?.contains(needle) ?? false
            })
            
            
            if let entryWithThisSpoiler = entryWithThisSpoiler
            {
                
                if let index = self.entries.firstIndex(of: entryWithThisSpoiler) {
                    Task {
                        self.entries[index] = await withSpoiler(entryWithThisSpoiler, spoiler: url) ?? entryWithThisSpoiler;
                    }
                }
            }
        }
        
    }
    
    
    func withSpoiler(_ entry:Entry, spoiler:URL) async -> Entry? {
        let withSpoiler = await bodyFormatter.showSpoiler(es: entry, spoiler: spoiler)
        
        return withSpoiler as? Entry;
        
    }
    
}


class MockEntriesViewModel : EntriesViewModel
{
    override init() {
        super.init();
        //
        //        let author = Author(avatar: "", login: "smaleckg", sex: .male, background: "", signupAt: "", color: 1);
        //        let entry = Entry(id:123, body: "wpis", favorite: false, userVote: 3, blocked: false, author: author, original: "", embed: nil, url: "www.wykop.pl", date: "11.12.2012", voteCount: 124, commentsCount: 44, status: .visible, app: "lurker",comments: nil)
        //        let entry2 = Entry(id:1243, body: "wpis drugi 123123", favorite: false, userVote: 3, blocked: false, author: author, original: "", embed: nil, url: "www.wykop.pl", date: "11.12.2012", voteCount: 124, commentsCount: 44, status: .visible, app: "lurker v2",comments: [])
        //
        //        self.entries = [entry,entry2];
        //
    }
}
