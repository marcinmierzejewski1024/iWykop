//
//  Registration.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 18/02/2022.
//

import Foundation
import Resolver


extension Resolver : ResolverRegistering {
    public static func registerAllServices() {

        register(ApiClient.self) { resolver, args in
            return AFNetworkApiClient()
        }.scope(.graph)

        register(EntriesService.self) { resolver, args in
            return EntriesService()
        }.scope(.graph)

        
    }
}
