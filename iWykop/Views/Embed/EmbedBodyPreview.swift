//
//  EmbedBodyPreview.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 15/03/2022.
//

import Foundation
import SwiftUI


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
    
    
    func playingGif() -> Bool {
        let fullscreen = fullScreenMode && embedVM.embed.animated;
        let autoplay = embedVM.settingsStore.autoplayAnimated && embedVM.embed.animated;
        
        return (fullscreen || autoplay) && isViewDisplayed;
    }
    
    var body: some View {
        HStack{
            //            if(viewModel.embed.type == .image) {
            
            if(playingGif()) {
                
                AnimatedImagePreview(embedVM: embedVM)
                
            } else {
//                let imageUrl = fullScreenMode ? viewModel.embed.getFullImageUrl() : viewModel.embed.getThumbnailImageURL()!;
                
                    ThumbnailImagePreview(embedVM: embedVM)
//                    .onTapGesture {
//                        self.fullScreenMode.toggle();
//                    }
                
            }
            //            } else if(viewModel.embed.type == .video){
            //                UIWKWebview(url: viewModel.embed.url)
            //            }
            
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
    
    var body: some View {
        let previewImageUrl = embedVM.embed.getThumbnailImageURL()!;
        
        CacheAsyncImage(
            url: URL(string:previewImageUrl)){ phase in
                switch phase {
                case .success(let image):
                    VStack(alignment: .leading) {
                        image.resizable()
                            .aspectRatio(contentMode: .fit).overlay {
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
                    Text(error.localizedDescription)
                    
                default:
                    Image("placeholder").resizable()
                        .aspectRatio(contentMode: .fit)
                    
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
                    ThumbnailImagePreview(embedVM: embedVM)

                    ProgressbarView(value: embedVM.downloadProgress).frame(maxHeight:5)
                }.frame(height: 350)
            }
            
        }.onAppear {
            embedVM.loadData()
            
        }
        
    }
    
}



