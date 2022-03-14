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
        return AnyView(EmptyView());
    }
    
    
}


class TagViewModel : BasePushableViewModel {


    
    init(name: String) {
        super.init()
        
        self.tagName = name;
        if(tagName == "tag1"){
            self.otherTags = [TagViewModel(name: "#monotyp"),TagViewModel(name: "#eeeee"),TagViewModel(name: "#wwwww")];
        }
        
        if(tagName == "#monotyp"){
            self.otherTags = [TagViewModel(name: "#ttt"),TagViewModel(name: "#aaaa"),TagViewModel(name: "#gfkjkgfj")];
        }
        if(tagName == "#ttt"){
            self.otherTags = [TagViewModel(name: "#asEWWE"),TagViewModel(name: "#DSDSD"),TagViewModel(name: "#NBNBN")];
        }
    }
    
    
    override func prepareView() -> AnyView
    {
        return AnyView(TagView(viewModel: self));
    }
    

    var tagName = "#awww";
    
    var otherTags = [TagViewModel]();
    
    
    
    
}








struct TagView : View {
    @ObservedObject var viewModel : TagViewModel;
    
    
    var body: some View {

            VStack {
                NavigationLink(destination: self.viewModel.childView(), isActive: $viewModel.childViewActive) { EmptyView() }

                if(self.viewModel.parentViewModel != nil) {
                    Text("back").font(.caption).padding().onTapGesture {
                            viewModel.dissmissSelf();
                    }
                }
                
                List(){
                    Text("List:")
                    
                    ForEach(self.viewModel.otherTags, id: \.tagName ) { item in
                        Text(item.tagName).onTapGesture {
                            
                            viewModel.presentChildViewModel(item);
                        }
                    }
                }
            }.navigationTitle(viewModel.tagName)
        
    }
}
