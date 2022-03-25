//
//  EmbedBodyPreview.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 15/03/2022.
//

import Foundation
import SwiftUI


struct EmbedBodyPreviewWithModal : View {
    
    var embed: Embed?;
    @State private var isPresented = false
    @State private var offset = CGSize.zero
    
    
    
    
    var body: some View {
        HStack{
            if let embed = embed {
                
                EmbedBodyPreview(embed: embed).onTapGesture {
                    self.isPresented.toggle()
                }
                .fullScreenCover(isPresented: $isPresented, content: {
                    
                    ZoomableScrollView {

                    EmbedBodyPreview(embed: embed, fullScreenMode: true).offset(x: offset.width * 0.2, y: offset.height * 0.7)
                    
                        .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .global).onChanged({ value in
                            
                            offset = value.translation
                            
                            
                        }).onEnded { value in
                            let horizontalAmount = value.translation.width as CGFloat
                            let verticalAmount = value.translation.height as CGFloat
                            
                            if abs(horizontalAmount) > 80 || abs(verticalAmount) > 80 {
                                withAnimation {
                                    isPresented.toggle();
                                }
                            }
                            
                            withAnimation {
                                offset = CGSize.zero;
                            }
                        }).frame(maxWidth: .infinity, maxHeight: .infinity).background(.clear)
                    }.ignoresSafeArea().background(BackgroundBlurView().ignoresSafeArea())
                    
                })
            }
            
        }.padding(0)
        
    }
    
}


struct EmbedBodyPreview : View {
    
    var embed: Embed;
    var fullScreenMode = false;
    
    
    var body: some View {
        HStack{
            if(embed.type == .image) {
                CacheAsyncImage(
                    url: URL(string:embed.url)){ phase in
                        switch phase {
                        case .success(let image):
                            VStack(alignment: fullScreenMode ? .center : .leading) {
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                        case .failure(let error):
                            Text(error.localizedDescription)
                            
                        default:
                            Image("placeholder").modifier(BodyStyle())
                            
                        }
                    }
            } else if(embed.type == .video){
                UIWKWebview(url: embed.url)
            }
            
        }
        
    }
}



