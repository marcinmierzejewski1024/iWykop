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
        if let decoded = url.absoluteString.decodeUrl() {
            if(decoded.starts(with: "iwykop:@")){
                let authorName = decoded.replacingOccurrences(of: "iwykop:@", with: "")
                if let author = try await authorService.getAuthor(name: authorName) {
                    return AuthorViewModel(author: author);
                }
            }
            
            if(decoded.starts(with: "iwykop:#")){
                let tagName = decoded.replacingOccurrences(of: "iwykop:#", with: "")
                if let tag = try await tagService.getTag(tag: tagName) {
                    return TagViewModel(name: tagName);
                }
            }
        }
        
        return nil;
        
        
    }
    
}
