//
//  SettingsStore.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 01/03/2022.
//

import Foundation

class SettingsStore : ObservableObject {
    var plus18Enabled : Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: "plus18Enabled")
            UserDefaults.standard.synchronize()
            self.objectWillChange.send();
        }
        get {
            return UserDefaults.standard.bool(forKey: "plus18Enabled")
        }
    }
    
//    var darkMode : Bool {
//        set {
//            UserDefaults.standard.set(newValue, forKey: "darkMode")
//            UserDefaults.standard.synchronize()
//            self.objectWillChange.send();
//            WykopColors.shared.updateCurrent();
//        }
//        get {
//            return UserDefaults.standard.bool(forKey: "darkMode")
//        }
//    }

    
    var selectedTheme : Int {
        set {
            UserDefaults.standard.set(newValue, forKey: "selectedTheme")
            UserDefaults.standard.synchronize()
            self.objectWillChange.send();
            WykopColors.shared.updateCurrent();
        }
        get {
            return UserDefaults.standard.integer(forKey: "selectedTheme")
        }
    }

    var openInSafari : Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: "openInSafari")
            UserDefaults.standard.synchronize()
            self.objectWillChange.send();
        }
        get {
            return UserDefaults.standard.bool(forKey: "openInSafari")
        }
    }
    
    var autoplayAnimated : Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: "autoplayAnimated")
            UserDefaults.standard.synchronize()
            self.objectWillChange.send();
        }
        get {
            return UserDefaults.standard.bool(forKey: "autoplayAnimated")
        }
    }

    
    var separateUpvotes : Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: "separateUpvotes")
            UserDefaults.standard.synchronize()
            self.objectWillChange.send();
        }
        get {
            return UserDefaults.standard.bool(forKey: "separateUpvotes")
        }
    }

    
    
}
