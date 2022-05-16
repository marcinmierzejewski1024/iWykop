//
//  iWykopApp.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 17/02/2022.
//

import SwiftUI
import DBDebugToolkit
import Resolver
import XNavigation


@main
struct iWykopApp: App {
    
    var navigation : Navigation?;
    
    private var window: UIWindow? {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
              let window = windowSceneDelegate.window else {
                  return nil
              }
        return window
    }
    
    init(){
        let shakeTrigger = DBShakeTrigger()
        DBDebugToolkit.setup(with: [shakeTrigger])
        
        
        WykopColors.shared.updateCurrent()
        
    }
    
    
    
    
    
    var body: some Scene {
        
        WindowGroup {
            
            WindowReader { window in
                
                if let navigation = Navigation(window: window!) {
                    
                    ContentViewWithWebview()
                        .environmentObject(navigation).background(WykopColors.shared.currentTheme.backgroundColor).ignoresSafeArea()
                }

            }

            
        }
    }
}
