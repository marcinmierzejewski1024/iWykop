//
//  UserViewModel.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 06/03/2022.
//


import Foundation
import Resolver
import OrderedCollections
import SwiftUI


class AuthorViewModel : BasePushableViewModel
{
    lazy var authorService: AuthorService = resolver.resolve()

    var author : Author;

    init(author : Author) {
        self.author = author;
    }

    
    override func prepareView() -> AnyView {
        return AnyView(AuthorDetailsView(authorVM: self));
    }
}
