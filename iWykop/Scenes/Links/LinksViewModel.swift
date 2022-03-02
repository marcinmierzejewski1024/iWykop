//
//  LinksViewModel.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 01/03/2022.
//

import Foundation
import Resolver
import OrderedCollections


class LinksViewModel : Resolving, ObservableObject
{
    lazy var linksService: LinksService = resolver.resolve()
    
    @Published var displayedLinks = OrderedSet<Link>();
    
    @Published var linksCollections = [LinksServiceCollections:OrderedSet<Link>](); //TODO:cache
    
    @Published var displayedCollection = LinksServiceCollections.Upcoming {
        didSet {
            //TODO:cache
        }
    };

    private var lastDownloadedPageCollections = [LinksServiceCollections:Int]();
    
    @Published var currentLink :Link?
//    @Published var LinkActive = false;
    
    func getNextLinks() async {
        
        await self.getLinks(page: self.downloadedPageForDisplayedCollection() + 1);
    }
    
    func refreshCurrentCollectionsLinks() async {
        
        do {
            let newlinks = try await linksService.getLinks(collection: self.displayedCollection);
            
            DispatchQueue.main.async {
                self.displayedLinks.removeAll()
                self.displayedLinks.append(contentsOf: newlinks)
                self.lastDownloadedPageCollections[self.displayedCollection] = 1;
            }
            
            
        } catch {
        }
    }
    

    
    func getLinks(page : Int = 1) async {
        do {
            
            let requestedCollection = self.displayedCollection;
            let newlinks = try await linksService.getLinks(collection: self.displayedCollection, page: page);

            DispatchQueue.main.async {

                self.displayedLinks.append(contentsOf: newlinks);
                self.lastDownloadedPageCollections[requestedCollection] = page;
                

            }

        } catch {
        }
    }
    
    
    private func downloadedPageForDisplayedCollection() -> Int {
        if let page = self.lastDownloadedPageCollections[self.displayedCollection] {
            return page;
        }
        
        return 0;
    }
    
    
    //TODO:
    
//
//    func refreshLink() async {
//
//        do {
//            if let id = currentLink?.id {
//                let newLink = try await linkService.getLink(id: id);
//
//                DispatchQueue.main.async {
//                    self.currentLink = newLink;
//                }
//            }
//
//        } catch {
//        }
//    }
    
    
//    func selectLink(_ Link:Link?) {
//
//        self.currentLink = Link;
//
//        if(self.currentLink != nil){
//            Task {
//
//                let fullLink = try await self.LinkService.getLink(id: self.currentLink!.id);
//
//                DispatchQueue.main.async {
//                    self.currentLink = fullLink;
//                }
//            }
//        }
//    }
    
    
}


