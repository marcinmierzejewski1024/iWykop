//
//  UserViewModel.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 06/03/2022.
//


import Foundation
import Resolver
import OrderedCollections

class AuthorViewModel : BasePushableViewModel, Resolving
{
    lazy var authorService: AuthorService = resolver.resolve()

    var author : Author;

    init(author : Author) {
        self.author = author;
    }

}
