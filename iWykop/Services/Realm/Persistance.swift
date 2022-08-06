//
//  Persistance.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 04/08/2022.
//

import Foundation
import Realm


public protocol Persistable {
    associatedtype ManagedObject: RLMEmbeddedObject
    init(managedObject: ManagedObject)
    func managedObject() -> ManagedObject
}
