//
//  iWykopApp.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 17/02/2022.
//

import SwiftUI
import DBDebugToolkit
import Resolver

@main
struct iWykopApp: App {
    
    let settingsStore = SettingsStore();
    let viewModel = EntriesViewModel(); // should viewModel be injected via DI?
    let linksViewModel = LinksViewModel();

    init(){
        let shakeTrigger = DBShakeTrigger()
        DBDebugToolkit.setup(with: [shakeTrigger])

    }
    
    
    var body: some Scene {
        
        WindowGroup {
            
            TabView {

                LinksView(viewModel: linksViewModel).task {
                    await linksViewModel.getLinks()
                }.tabItem {
                    Label("Main", systemImage: "w.square")
                }.onOpenURL { (url) in
                    print("\(url) to open!")
                }
                
                EntriesView(viewModel: viewModel).task {
                    await viewModel.getEntries();
                }.tabItem {
                    Label("Entries", systemImage: "number.square")
                }.onOpenURL { (url) in
                    print("\(url) to open!")
                }
                
                SettingsView().tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }.environmentObject(settingsStore).onOpenURL { (url) in
                    print("\(url) to open!")
                }
                
                SearchView().tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }.onOpenURL { (url) in
                    print("\(url) to open!")
                }
            }
            
        }
    }
}
