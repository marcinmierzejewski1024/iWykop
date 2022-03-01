//
//  EntriesView.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 18/02/2022.
//

import SwiftUI

struct EntriesView: View {
    @ObservedObject var viewModel : EntriesViewModel;
    
    @ViewBuilder
    var body: some View {
        
        
        NavigationView {
            
            
            
            GroupBox {
                DisclosureGroup("\(viewModel.requestedPeriod.rawValue)h") {
                    Text("6h").padding(5).onTapGesture {
                        Task {
                            await viewModel.changeRequestedPeriod(period: .from6);
                        }
                    }
                    Text("12h").padding(5).onTapGesture {
                        Task {
                            
                            await viewModel.changeRequestedPeriod(period: .from12);
                        }
                    }
                    Text("24h").padding(5).onTapGesture {
                        Task {
                            
                            await viewModel.changeRequestedPeriod(period: .from24);
                        }
                    }
                }
                
                EntriesListView(viewModel: self.viewModel)
                
            }
            
            
            
            
            
        }.navigationViewStyle(.stack)
        
    }
    
    
    struct EntriesListView: View {
        
        @ObservedObject var viewModel : EntriesViewModel;
        
        
        @ViewBuilder
        var body: some View {
            
            let entryTitle = "Wpis"
            
            List() {
                ForEach(viewModel.entries, id: \.id) { item in
                    
                    
                    NavigationLink(destination:
                                    EntryDetailsView(viewModel: self.viewModel).navigationTitle(entryTitle) , isActive: $viewModel.entryActive) {
                        EntryViewCell(entry: item).onTapGesture {
                            viewModel.selectEntry(item)
                            viewModel.entryActive = true;
                        }.onAppear {
                            if item == self.viewModel.entries.last {
                                Task {
                                    await self.viewModel.getNextEntries()
                                }
                            }
                        }
                    }
                    
                    
                }
            }.padding(0).refreshable {
                Task {
                    
                    await self.viewModel.refreshEntries()
                }
            }
            
            
            
        }
    }
    
}

struct EntryViewCell: View {
    var entry: Entry;
    
    
    var body: some View {
        HStack{
            Spacer()
            VStack(alignment: .leading) {
                EntryViewCellHeader(entry: entry)
                EntryBodyPreview(entry: entry)
            }
            
        }.padding(0)
        
    }
    
}

struct EntryViewCellHeader : View
{
    
    var entry: Entry;
    
    var body: some View {
        HStack{
            Text("comments: \(entry.commentsCount)")
            Spacer()
            Text(entry.author.login).bold()
            
        }.padding(0)
        
        
        
    }
    
}


struct EntryBodyPreview : View
{
    var entry: Entry;
    
    
    var body: some View {
        VStack{
            Text(entry.original ?? "")
            if(entry.embed != nil && entry.embed?.plus18 == false) {
                EmbedBodyPreviewWithModal(embed: entry.embed!)
            }
            
        }.padding(0)
        
    }
}


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
                        }).frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea().background(BackgroundBlurView())
                    
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
                            Image(systemName: "questionmark")
                            
                        }
                    }
            } else if(embed.type == .video){
                UIWKWebview(url: embed.url)
            }
            
        }
        
    }
}




struct BackgroundBlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

//struct EntriesView_Previews: PreviewProvider {
//    static var previews: some View {
//        EntriesView(viewModel: MockEntriesViewModel())
//    }
//}
