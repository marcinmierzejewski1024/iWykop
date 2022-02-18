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
    
    let persistenceController = PersistenceController.shared
    let viewModel = EntriesViewModel();

    init(){
        let shakeTrigger = DBShakeTrigger()
        DBDebugToolkit.setup(with: [shakeTrigger])

    }
    
    
    var body: some Scene {
        
        WindowGroup {
            EntriesView(viewModel: viewModel).task {
                viewModel.getEntries();
            }
        }
    }
}
