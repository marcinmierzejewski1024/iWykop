//
//  CommentViewModel.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 04/04/2022.
//

import Foundation
import SwiftUI

class CommentViewModel : BasePushableViewModel {
    
    @Published var comment : Comment;
    
    init(comment : Comment) {
        self.comment = comment;
    }
    
    override func prepareView() -> AnyView {
        return AnyView(CommentView(commentVM: self));
    }
    
}
