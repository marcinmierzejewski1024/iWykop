//
//  AnythingViewModelProvider.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 15/03/2022.
//

import Foundation
import Resolver


class AnythingViewModelProviderImpl : AnythingViewModelProvider, Resolving
{

    
    lazy var linkService: LinkService = resolver.resolve()
    lazy var authorService: AuthorService = resolver.resolve()
    lazy var tagService: TagService = resolver.resolve()
    lazy var entryService: EntryService = resolver.resolve()

    
    func getViewModelFor(url: URL) async throws -> BasePushableViewModel? {
        if(url.absoluteString.starts(with: "iWykop:@")){
            if let author = try await authorService.getAuthor(name: "todo") {
                return AuthorViewModel(author: author);
            }
        }
        
        if(url.absoluteString.starts(with: "iWykop:#")){
            if let tag = try await tagService.getTag(tag: "todo") {
                return TagViewModel(name: tag.name);
            }
        }
        
        return nil;
        
        
    }
    
}
