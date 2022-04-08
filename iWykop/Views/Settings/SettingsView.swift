//
//  SettingsView.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 01/03/2022.
//

import SwiftUI


struct SettingsView: View {
    @EnvironmentObject var settings: SettingsStore
    @Environment(\.openURL) var openURL

    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Content settings").modifier(TitleStyle())) {
                    Toggle(isOn: $settings.openInSafari) {
                        Text("Open links in external browser").modifier(SettingsTextStyle())
                    }
                    Toggle(isOn: $settings.plus18Enabled) {
                        Text("Show +18 content").modifier(SettingsTextStyle())
                    }
                    
                    Toggle(isOn: $settings.darkMode) {
                        Text("Dark mode").modifier(SettingsTextStyle())
                    }
                }
                
                Section(header: Text("Assets").modifier(TitleStyle())) {
                    Button("https://www.flaticon.com/free-icons/hide"){
                        openURL(URL(string: "https://www.flaticon.com/free-icons/hide")!)
                    }.font(.settingsFont())
                }
                
                
                
            }
            .navigationBarTitle(Text("Settings"))
        }
    }
}

//strus
