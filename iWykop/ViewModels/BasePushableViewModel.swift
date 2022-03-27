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


class BasePushableViewModel : ObservableObject, Resolving {
    
    lazy var bodyFormatter : BodyFormater = resolver.resolve();
    lazy var anythingProvider : AnythingViewModelProvider = resolver.resolve();
    
    @Published var parentViewModel : BasePushableViewModel?
    @Published var childViewModel : BasePushableViewModel?
    @Published var childViewActive = false;
    
    
    final func dissmissSelf() {
        DispatchQueue.main.async {
            
            self.parentViewModel?.dismissChildViewModel();
        }
    }
    
    final func dismissChildViewModel() {
        //TODO:fix - not working 100% - please use back button ;)
        DispatchQueue.main.async {
            
            self.childViewModel = nil;
            self.childViewActive = false;
            
            self.willChangeUp()
            self.willChangeDown()
        }
    }
    
    private final func willChangeUp(){
        DispatchQueue.main.async {
            
            self.objectWillChange.send()
            self.parentViewModel?.willChangeUp();
        }
    }
    
    private final func willChangeDown(){
        DispatchQueue.main.async {
            
            self.objectWillChange.send()
            self.childViewModel?.willChangeDown();
        }
    }
    
    final func presentChildViewModel(_ child:BasePushableViewModel){
        DispatchQueue.main.async {
            self.childViewModel = child;
            child.parentViewModel = self;
            self.childViewActive = true;
        }
    }
    
    func presentFromUrl(_ url:URL) async{
        
        do {
            if let childVM = try await self.anythingProvider.getViewModelFor(url: url) {
                self.presentChildViewModel(childVM);
            } else {
                await KSToastView.ks_showToast(NSLocalizedString("Unhandled", comment: "") + " \(url)");
            }
        } catch {
            print(error);
        }
        
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











