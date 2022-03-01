//
//  SettingsView.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 01/03/2022.
//

import SwiftUI


struct SettingsView: View {
    @EnvironmentObject var settings: SettingsStore
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Content settings")) {
                    Toggle(isOn: $settings.openInSafari) {
                        Text("Open links in external browser")
                    }
                    Toggle(isOn: $settings.plus18Enabled) {
                        Text("Show +18 content")
                    }
                    
                    Toggle(isOn: $settings.darkMode) {
                        Text("Dark mode")
                    }
                }
                
                
                
            }
            .navigationBarTitle(Text("Settings"))
        }
    }
}

//strus
