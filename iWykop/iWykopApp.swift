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
                
                NavigationView {
                    linksViewModel.prepareView()
                }.navigationViewStyle(.stack).tabItem {
                    Label("Main", systemImage: "w.square")
                }.modifier(BackgroundStyle())
                
                NavigationView {
                    viewModel.prepareView().modifier(BackgroundStyle())
                }.navigationViewStyle(.stack).tabItem {
                    Label("Entries", systemImage: "number.square")
                }
                
                
                SettingsView().tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }.environmentObject(settingsStore).modifier(BackgroundStyle())
                
                SearchView().tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }.modifier(BackgroundStyle())
            }.onOpenURL { (url) in
                print("\(url) to open!")
            }.font(.system(size: 12))
            
        }
    }
}
