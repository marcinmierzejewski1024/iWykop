//
//  LinkViewModel.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 14/03/2022.
//

import Foundation
import Resolver
import OrderedCollections
import KSToastView
import SwiftUI


class LinkViewModel : BasePushableViewModel
{
    var link: Link;
    lazy var linkService: LinkService = resolver.resolve()
    lazy var votersService: VotersService = resolver.resolve()

    
    init(link:Link){
        self.link = link;
        super.init();
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
    
    func getVoters() async throws -> [AuthorWithDate] {
        return try await votersService.getLinkVoters(id: self.link.id, downvotes: false);
    }
    
    func getDownvoters() async throws -> [AuthorWithDate] {
        return try await votersService.getLinkVoters(id: self.link.id, downvotes: true);
    }
    
    override func prepareView() -> AnyView {
        return AnyView(LinkDetailsView(link: self.link, linkVM: self));
    }
    
    
}


