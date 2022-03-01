//
//  SettingsStore.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 01/03/2022.
//

import Foundation

class SettingsStore : ObservableObject {
    @Published var plus18Enabled = false;
    @Published var darkMode = false;
    @Published var openInSafari = false;
}
