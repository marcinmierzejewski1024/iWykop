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
    let voteCount : VoteCount?
    @EnvironmentObject var settings: SettingsStore
    
    
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
            
            let showSeparated = settings.separateUpvotes && voteCount?.voteCountMinus != nil;
            VStack {
                if showSeparated {
                    HStack {
                        Text("+\(voteCount?.voteCountPlus ?? 0)").foregroundColor(WykopColors.shared.currentTheme.plusGreenColor).font(.countFont())
                        Text("-\(voteCount?.voteCountMinus ?? 0)").foregroundColor(WykopColors.shared.currentTheme.minusRedColor).font(.countFont())
                    }
                } else {
                    if let voteCount = voteCount?.upvotes {
                        if(voteCount >= 0) {
                            Text("+\(voteCount)").foregroundColor(WykopColors.shared.currentTheme.plusGreenColor).font(.countFont())
                        } else {
                            Text("\(voteCount)").foregroundColor(WykopColors.shared.currentTheme.minusRedColor).font(.countFont())
                            
                        }
                    }
                }
            }.onTapGesture {
                settings.separateUpvotes = !settings.separateUpvotes;
            }
            
            
            
        }.padding(.bottom, Margins.medium.rawValue)
    }
}

