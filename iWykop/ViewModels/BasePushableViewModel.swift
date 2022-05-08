//
//  BasePushableViewModel.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 13/03/2022.
//


import Foundation
import SwiftUI
import Resolver
import KSToastView
import XNavigation

class BasePushableViewModel : ObservableObject, Resolving {
    static var navigation : Navigation?;

    lazy var bodyFormatter : BodyFormater = resolver.resolve();
    lazy var anythingProvider : AnythingViewModelProvider = resolver.resolve();
    lazy var settingsStore : SettingsStore = resolver.resolve();

    
    func prepareView() -> AnyView {
        assertionFailure("You need override this method!")
        return AnyView(EmptyView());
    }
    
    func dismiss(animated: Bool = true){
        BasePushableViewModel.navigation?.dismiss(animated: animated, completion: nil);
    }
    
    
    
}











