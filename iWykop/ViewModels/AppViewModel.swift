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

    @Published var presentingSafariView = true
    @Published var startUrl = "http://github.com"
    var urlHandler : UrlHandler?;
    
    
    
    override func prepareView() -> AnyView {
        if(self.urlHandler == nil) {
            self.urlHandler = UrlHandler()
        }
        
        self.urlHandler?.appViewModel = self;
        return AnyView(ContentViewWithWebview(appViewModel: self))
    }
    
}



private struct UrlHandlerKey: EnvironmentKey {
    static let defaultValue = UrlHandler();
}

extension EnvironmentValues {
  var urlHandler: UrlHandler {
    get { self[UrlHandlerKey.self] }
    set { self[UrlHandlerKey.self] = newValue }
  }
}

class UrlHandler {
    
    var appViewModel : AppViewModel?

    
    func handleUrl(url : URL) {
        let absoluteString = url.absoluteString
            Task {
                if let newViewModel = try await appViewModel!.anythingProvider.getViewModelFor(url: url) {
                    BasePushableViewModel.navigation?.pushView(newViewModel.prepareView())
                } else {
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
