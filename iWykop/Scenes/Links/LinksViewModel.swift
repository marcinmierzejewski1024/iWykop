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
    
    @Published var links = OrderedSet<Link>();
    private var lastDownloadedPage = 1;
    
    @Published var currentLink :Link?
    @Published var LinkActive = false;
//
    
//    func getNextlinks() async {
//        await self.getlinks(page: self.lastDownloadedPage + 1);
//    }
    
    func refreshLinks() async {
        
        do {
            let newlinks = try await linksService.getLinks();
            
            DispatchQueue.main.async {
                self.links.removeAll()
                self.links.append(contentsOf: newlinks)
                self.lastDownloadedPage = 1;
            }
            
            
        } catch {
        }
    }
    
    
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
    
//    func getlinks(page : Int = 1) async {
//        do {
//            let newlinks = try await linksService.getLinks();
//
//            DispatchQueue.main.async {
//
//                self.links.append(contentsOf: newlinks);
//                self.lastDownloadedPage = page;
//
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


