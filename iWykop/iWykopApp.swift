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
                    await linksViewModel.refreshLinks()
                }.tabItem {
                    Label("Main", systemImage: "w.square")
                }
                
                EntriesView(viewModel: viewModel).task {
                    await viewModel.getEntries();
                }.tabItem {
                    Label("Entries", systemImage: "number.square")
                }
                
                SettingsView().tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }.environmentObject(settingsStore)
                
                SearchView().tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            }
            
//            ContentView()
        }
    }
}
