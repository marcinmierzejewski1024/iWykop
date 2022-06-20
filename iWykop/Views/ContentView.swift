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

    @State var appViewModel : AppViewModel;

    
    @StateObject var colors = WykopColors.shared;
    @EnvironmentObject var navigation: Navigation
    
    var body: some View {
        
        TabView {
            
            NavigationView {
                appViewModel.linksViewModel.prepareView().navigationTitle("").navigationBarHidden(true)
            }.navigationViewStyle(.stack).tabItem {
                Label("Main", systemImage: "w.square")
            }.modifier(BackgroundStyle())
            
            NavigationView {
                appViewModel.entriesViewModel.prepareView().navigationTitle("").navigationBarHidden(true)
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
                BasePushableViewModel.urlHandler = self.appViewModel.urlHandler;
            }.environmentObject(appViewModel.settingsStore).modifier(BackgroundStyle()).preferredColorScheme(colors.currentTheme.colorScheme)
        
    }
}



struct ContentViewWithWebview: View {
    
    @StateObject var appViewModel : AppViewModel;
    
    
    var body: some View {
        
        ContentView(appViewModel: appViewModel).onOpenURL(perform: { url in
            appViewModel.urlHandler?.handleUrl(url: url);
        })
        
        .safariView(isPresented: $appViewModel.presentingSafariView) {
            SafariView(
                url: URL(string: appViewModel.startUrl)!,
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

