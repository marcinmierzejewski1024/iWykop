//
//  Persistance.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 04/08/2022.
//

import Foundation
import RealmSwift

public protocol Persistable {
    associatedtype ManagedObject: Object
    init(managedObject: ManagedObject)
    func managedObject() -> ManagedObject
}
