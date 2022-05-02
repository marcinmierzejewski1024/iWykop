//
//  AuthorLabel.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 01/03/2022.
//

import SwiftUI

struct AuthorWithDateHeader: View {
    let author : Author
    let date : Date?
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
                        Image("userPlaceholder").resizable()
                            .aspectRatio(contentMode: .fit).frame(width: 36, height: 36)
                        
                    }
                }
            VStack(alignment: .leading,spacing: 4) {
                Text(author.login).bold().modifier(LoginStyle(loginColor: WykopColors.shared.currentTheme.authorColors[author.color] ?? WykopColors.shared.currentTheme.textColor))
                Text(date?.timeAgoDisplay() ?? "").modifier(DateStyle());

            }
            
            Spacer()
            
        }.padding(.bottom, Margins.medium.rawValue)
    }
}

