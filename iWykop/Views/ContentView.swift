//
//  ContentView.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 30/03/2022.
//

import SwiftUI
import XNavigation
import KSToastView
import BetterSafariView

struct ContentView: View {
    
    let settingsStore = SettingsStore();
    let viewModel = EntriesViewModel();
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
        }.accentColor(colors.currentTheme.accentColor).tint(colors.currentTheme.accentColor).font(.bodyFont())
            .onAppear {
                BasePushableViewModel.navigation = self.navigation;
            }.environmentObject(settingsStore).modifier(BackgroundStyle()).preferredColorScheme(colors.currentTheme.colorScheme)
        
    }
}



struct ContentViewWithWebview: View {
    
    //TODO:move to ViewModel!
    @State var presentingSafariView = false
    @State var startUrl = "http://github.com"
    @State var settingsStore = SettingsStore();
    @State var anythingProvider = AnythingViewModelProviderImpl();
    
    @Environment(\.openURL) var openInExternalSafari
    
    
    
    var body: some View {
        
        ContentView().onOpenURL(perform: { url in
            
            Task {
                if let newViewModel = try await self.anythingProvider.getViewModelFor(url: url) {
                    BasePushableViewModel.navigation?.pushView(newViewModel.prepareView())
                } else {
                    if(settingsStore.openInSafari) {
                        self.openInExternalSafari(url)
                    } else {
                        self.startUrl = url.absoluteString;
                        self.presentingSafariView = true;
                        
                    }
                }
            }
            
            
        })
        
        .safariView(isPresented: $presentingSafariView) {
            SafariView(
                url: URL(string: startUrl)!,
                configuration: SafariView.Configuration(
                    entersReaderIfAvailable: false,
                    barCollapsingEnabled: true
                )
            )
            .preferredBarAccentColor(.clear)
            .preferredControlAccentColor(.accentColor)
            .dismissButtonStyle(.done)
        }
    }
}
