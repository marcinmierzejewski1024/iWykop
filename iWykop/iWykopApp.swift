//
//  iWykopApp.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 17/02/2022.
//

import SwiftUI
import DBDebugToolkit

@main
struct iWykopApp: App {
    
    let viewModel = EntriesViewModel();
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
                    Label("Mikroblog", systemImage: "number.square")
                }
                
                EntriesView(viewModel: viewModel).task {
//                    await viewModel.getEntries();
                }.tabItem {
                    Label("Settings", systemImage: "list.dash")
                }
                
                EntriesView(viewModel: viewModel).task {
//                    await viewModel.getEntries();
                }.tabItem {
                    Label("Search", systemImage: "s.square")
                }
            }
            
//            ContentView()
        }
    }
}

//TODO:move
extension URLCache {
    
    static let imageCache = URLCache(memoryCapacity: 512*1000*1000, diskCapacity: 10*1000*1000*1000)
}
