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
            
            VStack (alignment: .leading) {
                CacheAsyncImage(
                    url: URL(string:author.avatar)){ phase in
                        switch phase {
                        case .success(let image):
                            VStack {
                                image.resizable()
                                    .aspectRatio(contentMode: .fit).frame(width: 36, height: 36)
                            }
                            
                        default:
                            Image(systemName: "questionmark").modifier(BodyStyle())
                            
                        }
                    }
                Text(date?.timeAgoDisplay() ?? "");
                
            }
            Spacer()
            
            Text(author.login).bold().foregroundColor(WykopColors.currentTheme.authorColors[author.color] ?? .black)
        }.padding(.bottom, 6)
    }
}

