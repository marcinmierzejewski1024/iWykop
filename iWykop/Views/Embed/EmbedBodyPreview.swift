//
//  EmbedBodyPreview.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 15/03/2022.
//

import Foundation
import SwiftUI


struct EmbedBodyPreviewWithModal : View {
    
    @State var viewModel: EmbedViewModel;
    @State private var isPresented = false
    @State private var offset = CGSize.zero
    
    
    
    
    var body: some View {
        HStack{
            
            EmbedBodyPreview(viewModel: viewModel).onTapGesture {
                self.isPresented.toggle()
            }
            .fullScreenCover(isPresented: $isPresented, content: {
                
                ZoomableScrollView {
                    
                    EmbedBodyPreview(viewModel: viewModel, fullScreenMode: true).offset(x: offset.width * 0.2, y: offset.height * 0.7)
                    
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
            
            
        }.padding(0)
    }
    
    
}


struct EmbedBodyPreview : View {
    
    @State var viewModel: EmbedViewModel;
    @State var fullScreenMode = false;
    @EnvironmentObject var settings: SettingsStore
    @State var isViewDisplayed = false
    
    
    func playingGif() -> Bool {
        let fullscreen = fullScreenMode && viewModel.embed.animated;
        let autoplay = settings.autoplayAnimated && viewModel.embed.animated;
        
        return (fullscreen || autoplay) && isViewDisplayed;
    }
    
    var body: some View {
        HStack{
            //            if(viewModel.embed.type == .image) {
            
            if(playingGif()) {
                
                AnimatedImagePreview(viewModel: viewModel)
                
            } else {
//                let imageUrl = fullScreenMode ? viewModel.embed.getFullImageUrl() : viewModel.embed.getThumbnailImageURL()!;
                
                    ThumbnailImagePreview(viewModel: viewModel).onTapGesture {
                        self.fullScreenMode.toggle();
                    }
                
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
    @State var viewModel: EmbedViewModel;
    
    var body: some View {
        let previewImageUrl = viewModel.embed.getThumbnailImageURL()!;
        
        CacheAsyncImage(
            url: URL(string:previewImageUrl)){ phase in
                switch phase {
                case .success(let image):
                    VStack(alignment: .leading) {
                        image.resizable()
                            .aspectRatio(contentMode: .fit).overlay {
                                if let label = viewModel.embed.label() {
                                    VStack {
                                        Spacer()
                                        HStack {
                                            Spacer()
                                            Text(label).font(.title).bold().foregroundColor(.blue).padding(10).background(Color.white).cornerRadius(10.0).padding(10);
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
    @ObservedObject var viewModel: EmbedViewModel;
    
    
    var body: some View {
        VStack{
            if(viewModel.animatedImageData != nil) {
                A9_SwiftyGif_final(gifData:viewModel.animatedImageData).frame(height: 350)
            } else {
                VStack {
                    ThumbnailImagePreview(viewModel: viewModel)

                    ProgressbarView(value: viewModel.downloadProgress).frame(maxHeight:5)
                }.frame(height: 350)
            }
            
        }.onAppear {
            viewModel.loadData()
            
        }
        
    }
    
}



