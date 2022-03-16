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
    
    
    override func prepareView() -> AnyView {
        return AnyView(LinkDetailsView(link: self.link, viewModel: self));
    }
    
    
}


