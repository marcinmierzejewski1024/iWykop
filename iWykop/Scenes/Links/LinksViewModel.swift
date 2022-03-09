//
//  LinksViewModel.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 01/03/2022.
//

import Foundation
import Resolver
import OrderedCollections
import KSToastView


class LinksViewModel : Resolving, ObservableObject
{
    lazy var linksService: LinksService = resolver.resolve()
    lazy var linkService: LinkService = resolver.resolve()

    
    @Published var displayedLinks = OrderedSet<Link>();
    
    @Published var linksCollections = [LinksServiceCollections:OrderedSet<Link>](); //TODO:cache
    
    @Published var displayedCollection = LinksServiceCollections.Upcoming {
        didSet {
            //TODO:cache
        }
    };

    private var lastDownloadedPageCollections = [LinksServiceCollections:Int]();
    
    
    func getNextLinks() async {
        
        await self.getLinks(page: self.downloadedPageForDisplayedCollection() + 1);
    }
    
    func refreshCurrentCollectionsLinks() async {
        
        do {
            let newlinks = try await linksService.getLinks(collection: self.displayedCollection, page: 1);
            
            DispatchQueue.main.async {
                self.displayedLinks.removeAll()
                self.displayedLinks.append(contentsOf: newlinks)
                self.lastDownloadedPageCollections[self.displayedCollection] = 1;
            }
            
            
        } catch {
            print(error);
            DispatchQueue.main.async {
                KSToastView.ks_showToast(error.localizedDescription);
            }

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
            print(error);
            DispatchQueue.main.async {
                KSToastView.ks_showToast(error.localizedDescription);
            }

        }
    }
    
    
    private func downloadedPageForDisplayedCollection() -> Int {
        if let page = self.lastDownloadedPageCollections[self.displayedCollection] {
            return page;
        }
        
        return 0;
    }
    
    
    func refreshLink(_ old:Link) async -> Link? {

        do {
            let newLink = try await linkService.getLink(id: old.id);

            return newLink;

        } catch {
            print(error)
            DispatchQueue.main.async {
                KSToastView.ks_showToast(error.localizedDescription)
            }
            
        }
        return nil;
    }
    
    
    
}


