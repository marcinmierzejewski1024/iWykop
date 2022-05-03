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
    let voteCount : Int?

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
                Text(author.login).strikethrough(author.isBanned(), color: nil).bold().modifier(LoginStyle(loginColor: WykopColors.shared.currentTheme.authorColors[author.color] ?? WykopColors.shared.currentTheme.textColor))
                Text(date?.timeAgoDisplay() ?? "").modifier(DateStyle());

            }
            
            Spacer()
            if let voteCount = voteCount {
                if(voteCount >= 0) {
                    Text("+\(voteCount)").foregroundColor(WykopColors.shared.currentTheme.plusGreenColor).modifier(BodyStyle())
                } else {
                    Text("\(voteCount)").foregroundColor(WykopColors.shared.currentTheme.minusRedColor).modifier(BodyStyle())

                }
            }

            
        }.padding(.bottom, Margins.medium.rawValue)
    }
}

