//
//  BasePushableViewModel.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 13/03/2022.
//


import Foundation
import SwiftUI



class BasePushableViewModel : ObservableObject {
    
    
    @Published var parentViewModel : BasePushableViewModel?
    @Published var childViewModel : BasePushableViewModel?
    @Published var childViewActive = false;


    final func dissmissSelf() {
        self.parentViewModel?.dismissChildViewModel();
    }

    final func dismissChildViewModel() {
        //TODO:fix - not working 100% - please use back button ;)
        self.childViewModel = nil;
        self.childViewActive = false;

        self.willChangeUp()
        self.willChangeDown()
    }
    
    private final func willChangeUp(){
        self.objectWillChange.send()
        self.parentViewModel?.willChangeUp();
    }
    
    private final func willChangeDown(){
        self.objectWillChange.send()
        self.childViewModel?.willChangeDown();
    }

    final func presentChildViewModel(_ child:BasePushableViewModel){
        self.childViewModel = child;
        child.parentViewModel = self;
        self.childViewActive = true;
    }


    final func childView() -> AnyView {
        if(self.childViewModel != nil) {
            return self.childViewModel!.prepareView();
        }

        return AnyView(Text("??????"));
    }
    
    func prepareView() -> AnyView {
        assertionFailure("You need override this method!")
        return AnyView(EmptyView());
    }

    

    
}











