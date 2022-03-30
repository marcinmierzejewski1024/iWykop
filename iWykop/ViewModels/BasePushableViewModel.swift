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
    
    func prepareView() -> AnyView {
        assertionFailure("You need override this method!")
        return AnyView(EmptyView());
    }
    
    
    
    
}











