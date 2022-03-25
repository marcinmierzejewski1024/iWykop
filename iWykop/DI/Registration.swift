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

        
        register(AFNetworkApiClient.self) { resolver, args in
            return AFNetworkApiClient()
        }.scope(.graph)

        
        register(ApiClient.self) { resolver, args in
            return AFNetworkApiClient()
        }.scope(.graph)

        register(EntriesService.self) { resolver, args in
            return EntriesServiceImpl()
        }.scope(.graph)

        register(EntryService.self) { resolver, args in
            return EntryServiceImpl()
        }.scope(.graph)
        
        register(LinksService.self) { resolver, args in
            return LinksServiceImpl()
        }.scope(.graph)

        register(LinkService.self) { resolver, args in
            return LinkServiceImpl()
        }.scope(.graph)

        register(SettingsStore.self) { resolver, args in
            return SettingsStore()
        }.scope(.graph)
        
        register(BodyFormater.self) { resolver, args in
            return BodyFormater()
        }.scope(.graph)
        
        register(TagService.self) { resolver, args in
            return TagServiceImpl()
        }.scope(.graph)
        
        register(AnythingViewModelProvider.self) { resolver, args in
            return AnythingViewModelProviderImpl()
        }.scope(.graph)
        


        
    }
}
