//
//  Coordinator.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 18/02/2022.
//

import Foundation
protocol CoordinatorDelegate : AnyObject {
    func didFinish();
}

class Coordinator {
    
    weak var delegate: CoordinatorDelegate?
    
    func start() {
        
    }
    
    func finish() {
        delegate?.didFinish()
    }
}
