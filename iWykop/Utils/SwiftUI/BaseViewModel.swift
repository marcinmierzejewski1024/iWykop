//
//  BaseViewModel.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 13/03/2022.
//

import Foundation
import SwiftUI


class BaseViewModel : ObservableObject {
    
    var childViewActive = false;
    var parentViewModel : BaseViewModel?
    var childViewModel : BaseViewModel? { didSet {
            self.childViewActive = self.childViewModel != nil;
        }
    }
    
    func dissmissSelf() {
        self.parentViewModel?.dismissChildViewModel();
    }
    
    func dismissChildViewModel() {
        self.childViewModel = nil;
    }
    
    func presentChildViewModel(_ child:BaseViewModel){
        self.childViewModel = child;
    }
    
    
    func view() -> some View {
        return ContentView();
    }
    
}


struct ContainerView<Content: View> : View {
    var content: () -> Content

    @ObservedObject var viewModel : BaseViewModel;
    
    
    var body: some View {
        NavigationView {
            content()
//            NavigationLink(isAc)
        }
    }
}
