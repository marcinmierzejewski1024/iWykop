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
    
    var body: some View {
        
        
        VStack {
            CacheAsyncImage(
                url: URL(string:authorVM.author.background ?? "https://picsum.photos/200/300")){ phase in
                    switch phase {
                    case .success(let image):
                        VStack {
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        
                    default:
                        Text("TLO!")
//                        EmptyView();
                        
                        
                    }
                }
            
            HStack{
                CacheAsyncImage(
                    url: URL(string:authorVM.author.avatar)){ phase in
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
                    Text(authorVM.author.login).strikethrough(authorVM.author.isBanned(), color: nil).bold().modifier(LoginStyle(loginColor: WykopColors.shared.currentTheme.authorColors[authorVM.author.color] ?? WykopColors.shared.currentTheme.textColor))
                }
                
                Spacer()
                
                
                
                
            }.padding(.bottom, Margins.medium.rawValue)
        }
        
    }
}

