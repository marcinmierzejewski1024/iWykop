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
        return AnyView(CommentView(commentVM: self).onOpenURL(perform: { url in
            self.handle(url: url)
        }));
    }
    
    override func handle(url: URL){

        if(url.absoluteString.contains("iwykop:spoiler:")) {
            Task {
                self.comment = await withSpoiler(self.comment, spoiler: url) ?? self.comment;
            }

        }
    }
    
    func withSpoiler(_ comment:Comment, spoiler:URL) async -> Comment? {
        let withSpoiler = await bodyFormatter.showSpoiler(es: comment, spoiler: spoiler)
        
        return withSpoiler as? Comment;
        
    }

}
