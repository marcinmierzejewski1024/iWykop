//
//  EmbedBodyPreview.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 15/03/2022.
//

import Foundation
import SwiftUI
import YouTubePlayerKit


struct EmbedBodyPreviewWithModal: View {
    
    @State var embedVM: EmbedViewModel;
    @State private var offset = CGSize.zero
    
    
    
    
    var body: some View {
        HStack{
                
                ZoomableScrollView {
                    
                    EmbedBodyPreview(embedVM: embedVM, fullScreenMode: true).offset(x: offset.width * 0.2, y: offset.height * 0.7)
                    
                        .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .global).onChanged({ value in
                            
                            offset = value.translation
                            
                            
                        }).onEnded { value in
                            let horizontalAmount = value.translation.width as CGFloat
                            let verticalAmount = value.translation.height as CGFloat
                            
                            if abs(horizontalAmount) > 80 || abs(verticalAmount) > 80 {
                                withAnimation {
                                    embedVM.dismiss()
                                }
                            }
                            
                            withAnimation {
                                offset = CGSize.zero;
                            }
                        }).frame(maxWidth: .infinity, maxHeight: .infinity).background(.clear)
                }.ignoresSafeArea().background(BackgroundBlurView().ignoresSafeArea())
                
            
        }.padding(0)
    }
    
    
}


struct EmbedBodyPreview : View {
    
    @State var embedVM: EmbedViewModel;
    @State var fullScreenMode = false;
    @State var isViewDisplayed = false
    
    
    func playing() -> Bool {
        let fullscreen = fullScreenMode
        let isGif = embedVM.embed.animated;
        let isVideo = embedVM.embed.type == .video;
        
        let autoplay = embedVM.settingsStore.autoplayAnimated && embedVM.embed.animated;
        
        return (fullscreen || autoplay) && isViewDisplayed && (isGif || isVideo);
    }
    
    
    var body: some View {
        HStack{
            
            if(playing()) {
                
                if(embedVM.embed.type == .video) {
                    VideoPreview(embedVM: embedVM)
                } else {
                    AnimatedImagePreview(embedVM: embedVM)
                }
            } else {

                ThumbnailImagePreview(embedVM: embedVM, fullScreenMode: fullScreenMode)
                
            }

            
        }.onAppear {
            self.isViewDisplayed = true
        }
        .onDisappear {
            self.isViewDisplayed = false
        }
        
    }
}

struct ThumbnailImagePreview : View {
    @State var embedVM: EmbedViewModel;
    let fullScreenMode : Bool;

    func maxWidth() -> CGFloat? {
        return fullScreenMode ? nil : MaxSizes.previewWidth.rawValue;
    }
    
    func maxHeight() -> CGFloat? {
        return fullScreenMode ? nil : MaxSizes.previewHeight.rawValue;
    }
    
    var body: some View {
        let previewImageUrl = embedVM.embed.getThumbnailImageURL()!;
        
        CacheAsyncImage(
            url: URL(string:previewImageUrl)){ phase in
                switch phase {
                case .success(let image):
                    VStack(alignment: .leading) {
                        image.resizable()
                            .aspectRatio(contentMode: .fit).frame(maxWidth:self.maxWidth(), maxHeight: self.maxHeight()).overlay {
                                if let label = embedVM.embed.label() {
                                    VStack {
                                        Spacer()
                                        HStack {
                                            Spacer()
                                            Text(label).font(.title3).bold().foregroundColor(.blue).padding(Margins.medium.rawValue).background(Color.white).cornerRadius(6.0).padding(Margins.medium.rawValue);
                                        }
                                        
                                        
                                    }
                                    
                                }
                                
                            }
                    }
                case .failure(let error):
                    #if DEBUG
                    Text(error.localizedDescription)
                    #endif
                default:
                    Image("placeholder").resizable()
                        .aspectRatio(contentMode: .fit).frame(maxWidth:self.maxWidth(), maxHeight: self.maxHeight())
                    
                }
            }
    }
}


struct AnimatedImagePreview : View {
    @ObservedObject var embedVM: EmbedViewModel;
    
    
    var body: some View {
        VStack{
            if(embedVM.animatedImageData != nil) {
                A9_SwiftyGif_final(gifData:embedVM.animatedImageData).frame(height: 350)
            } else {
                VStack {
                    ThumbnailImagePreview(embedVM: embedVM, fullScreenMode: false)

                    ProgressbarView(value: embedVM.downloadProgress).frame(maxHeight:5)
                }.frame(height: 350)
            }
            
        }.onAppear {
            embedVM.loadData()
            
        }
        
    }
    
}



struct VideoPreview: View
{
    @ObservedObject var embedVM: EmbedViewModel;
    var body: some View {
        VStack{
            YouTubePlayerView("https://youtube.com/watch?v=psL_5RIBqnY")
//            UIWKWebview(url: embedVM.embedVideoUrl())
        }
    }
}
