//
//  AuthorDetailsView.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 15/07/2022.
//

import Foundation
import SwiftUI

struct AuthorDetailsView: View {
    let authorVM : AuthorViewModel
    
    func backgroundHeight() -> CGFloat {
        return authorVM.author.background != nil ? 140.0 : 20.0;
    };
    
    
    var body: some View {
        ZStack {
            VStack {
                
                if let backgroundUrl = authorVM.author.background {
                    CacheAsyncImage(
                        url: URL(string:backgroundUrl)){ phase in
                            switch phase {
                            case .success(let image):
                                VStack {
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill).frame(height: self.backgroundHeight(), alignment: .center)                .ignoresSafeArea()

                                }
                                
                            default:
                                Image("placeholder").resizable()
                                    .aspectRatio(contentMode: .fill).frame(height: self.backgroundHeight(), alignment: .center)                .ignoresSafeArea()

                                
                                
                            }
                        }
                    Spacer()
                }
            }
            
            VStack {
                
                
                HStack{
                    CacheAsyncImage(
                        url: URL(string:authorVM.author.avatar)){ phase in
                            switch phase {
                            case .success(let image):
                                VStack {
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit).frame(width: MaxSizes.profileThumbsize.rawValue, height: MaxSizes.profileThumbsize.rawValue).padding(Margins.tiny.rawValue)
                                }
                                
                            default:
                                Image("userPlaceholder").resizable()
                                    .aspectRatio(contentMode: .fit).frame(width: MaxSizes.profileThumbsize.rawValue, height: MaxSizes.profileThumbsize.rawValue).padding(Margins.tiny.rawValue)
                                
                            }
                        }
                    VStack(alignment: .leading,spacing: 4) {
                        Text(authorVM.author.login).strikethrough(authorVM.author.isBanned(), color: nil).bold().modifier(LoginStyle(loginColor: WykopColors.shared.currentTheme.authorColors[authorVM.author.color] ?? WykopColors.shared.currentTheme.textColor))
                        if let signUp = authorVM.author.signupAt {
                            Text(NSLocalizedString("Since:", comment: "") + signUp.timeAgoDisplayShort()).foregroundColor(WykopColors.shared.currentTheme.textColor)
                        }
                    }
                    
                    Spacer()
                    
                    
                    
                    
                }.padding(Margins.medium.rawValue).background(WykopColors.shared.currentTheme.backgroundColor).cornerRadius(4.0)
                
                
                
                Spacer()
            }

            
        }
    }
}



struct AuthorDetailsView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        
        let vm = AuthorViewModel(author: Author(avatar: "https://picsum.photos/200/300", login: "mock", sex: .male, background: "https://picsum.photos/200/300", signupAt: Date(), color: 0))
        AuthorDetailsView(authorVM:vm)
    }
}
