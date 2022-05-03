//
//  ContentView.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 30/03/2022.
//

import SwiftUI
import XNavigation
import KSToastView

struct ContentView: View {
    
    let settingsStore = SettingsStore();
    let viewModel = EntriesViewModel(); // should viewModel be injected via DI?
    let linksViewModel = LinksViewModel();
    
    @StateObject var colors = WykopColors.shared;
    @EnvironmentObject var navigation: Navigation

    var body: some View {

        TabView {
            
            NavigationView {
                linksViewModel.prepareView().navigationTitle("").navigationBarHidden(true)
            }.navigationViewStyle(.stack).tabItem {
                Label("Main", systemImage: "w.square")
            }.modifier(BackgroundStyle())
            
            NavigationView {
                viewModel.prepareView().navigationTitle("").navigationBarHidden(true)
            }.navigationViewStyle(.stack).tabItem {
                Label("Entries", systemImage: "number.square")
            }.modifier(BackgroundStyle())
            
            
            SettingsView().tabItem {
                Label("Settings", systemImage: "gearshape.fill")
            }
            
            SearchView().tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }.modifier(BackgroundStyle())
        }.onOpenURL { (url) in
            Task {
                NSLog("whyy???");
                if let newViewModel = try await self.viewModel.anythingProvider.getViewModelFor(url: url) {
                    BasePushableViewModel.navigation?.pushView(newViewModel.prepareView())
                } else {
                    await KSToastView.ks_showToast(NSLocalizedString("Unhandled", comment: "") + " \(url)");
                }

            }

            
        }.accentColor(colors.currentTheme.accentColor).tint(colors.currentTheme.accentColor).font(.bodyFont())
            .onAppear {
                BasePushableViewModel.navigation = self.navigation;
            }.environmentObject(settingsStore).modifier(BackgroundStyle()).preferredColorScheme(colors.currentTheme.colorScheme)
        
    }
}
