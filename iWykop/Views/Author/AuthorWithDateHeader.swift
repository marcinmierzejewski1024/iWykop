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
    @EnvironmentObject var theme : WykopColors

//    let onLoginTap : (String) -> Void?
    @EnvironmentObject var settings: SettingsStore
    
    
    var body: some View {
        HStack{
            CacheAsyncImage(
                url: URL(string:author.avatar)){ phase in
                    switch phase {
                    case .success(let image):
                        VStack {
                            image.resizable()
                                .aspectRatio(contentMode: .fit).frame(width: MaxSizes.profileThumbsize.rawValue, height: MaxSizes.profileThumbsize.rawValue)
                        }
                        
                    default:
                        Image("userPlaceholder").resizable()
                            .aspectRatio(contentMode: .fit).frame(width: MaxSizes.profileThumbsize.rawValue, height: MaxSizes.profileThumbsize.rawValue)
                        
                    }
                }.onTapGesture {
                    self.openAuthorDetails()
                }
            VStack(alignment: .leading,spacing: 4) {
                Text(author.login).strikethrough(author.isBanned(), color: nil).bold().modifier(LoginStyle(loginColor: theme.currentTheme.authorColors[author.color] ?? theme.currentTheme.textColor)).onTapGesture {
                    self.openAuthorDetails()
                }
                Text(date?.timeAgoDisplay() ?? "").modifier(DateStyle());
                
            }
            
            Spacer()
            
            let showSeparated = settings.separateUpvotes && voteCount?.voteCountMinus != nil;
            VStack {
                if showSeparated {
                    HStack {
                        Text("+\(voteCount?.voteCountPlus ?? 0)").foregroundColor(theme.currentTheme.plusGreenColor).font(.countFont())
                        Text("-\(voteCount?.voteCountMinus ?? 0)").foregroundColor(theme.currentTheme.minusRedColor).font(.countFont())
                    }
                } else {
                    if let voteCount = voteCount?.upvotes {
                        if(voteCount >= 0) {
                            Text("+\(voteCount)").foregroundColor(theme.currentTheme.plusGreenColor).font(.countFont())
                        } else {
                            Text("\(voteCount)").foregroundColor(theme.currentTheme.minusRedColor).font(.countFont())
                            
                        }
                    }
                }
            }.onTapGesture {
                settings.separateUpvotes = !settings.separateUpvotes;
            }
            
            
            
        }.padding(.bottom, Margins.medium.rawValue)
    }
    
    
    func openAuthorDetails()
    {
        if let url = URL(string: "iwykop:@\(author.login)") {
            BasePushableViewModel.urlHandler?.handleUrl(url: url)
        }
    }
}

