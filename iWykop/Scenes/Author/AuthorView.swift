//
//  AuthorLabel.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 01/03/2022.
//

import SwiftUI

struct AuthorView: View {
    let author : Author
    var body: some View {
        HStack{
            CacheAsyncImage(
                url: URL(string:author.avatar)){ phase in
                    switch phase {
                    case .success(let image):
                        VStack {
                            image.resizable()
                                .aspectRatio(contentMode: .fit).frame(width: 36, height: 36)
                        }
                        
                    default:
                        Image(systemName: "questionmark")
                        
                    }
                }
            Spacer()
            Text(author.login).bold().foregroundColor(WykopColors.authorColors[author.color] ?? .black)
        }
    }
}

//struct AuthorLabel_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthorLabel()
//    }
//}
