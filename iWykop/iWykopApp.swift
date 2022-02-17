//
//  iWykopApp.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 17/02/2022.
//

import SwiftUI

@main
struct iWykopApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
