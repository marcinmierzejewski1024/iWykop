//
//  Navigation.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 08/05/2022.
//

import Foundation
import XNavigation
import SwiftUI

extension Navigation {
    
    public func presentFullScreen<Content: View>(_ view: Content, animated: Bool = true) {
        let controller = DestinationHostingController(rootView: view.environmentObject(self))
        controller.modalPresentationStyle = .overCurrentContext;
        present(controller, animated: animated)
    }

}
