//
//  AppViewModel.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 04/06/2022.
//

import Foundation
import SwiftUI

class AppViewModel : BasePushableViewModel
{
    
        
    @Environment(\.openURL) var openInExternalSafari
    
    let entriesViewModel = EntriesViewModel();
    let linksViewModel = LinksViewModel();
    
    @Published var presentingSafariView = false
    @Published var startUrl = "http://github.com"
    let urlHandler = UrlHandler();
    
    
    
    override func prepareView() -> AnyView {

        self.urlHandler.appViewModel = self;
        return AnyView(ContentViewWithWebview(appViewModel: self))
    }
    
}




class UrlHandler {
    
    weak var appViewModel : AppViewModel?
    
    
    @MainActor func handleUrl(url : URL) {
        let absoluteString = url.absoluteString
        
        Task {
            if let newViewModel = try await appViewModel!.anythingProvider.getViewModelFor(url: url) {
                BasePushableViewModel.navigation?.pushView(newViewModel.prepareView())
            } else {

                if((url.scheme?.lowercased().contains("http")) ?? false) {
                    
                    if(appViewModel!.settingsStore.openInSafari) {
                        appViewModel!.openInExternalSafari(url)
                    } else {
                        appViewModel!.startUrl = absoluteString;
                        appViewModel!.presentingSafariView = true;
                        
                    }
                }
            }
        }
        
    }
}
