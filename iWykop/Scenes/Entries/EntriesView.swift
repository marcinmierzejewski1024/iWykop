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
            
            
            
            VStack {
                DisclosureGroup("\(viewModel.requestedPeriod.rawValue)h") {
                    Text("6h").font(.headline).padding(5).onTapGesture {
                        Task {
                            await viewModel.changeRequestedPeriod(period: .from6);
                        }
                    }
                    Text("12h").font(.headline).padding(5).onTapGesture {
                        Task {
                            
                            await viewModel.changeRequestedPeriod(period: .from12);
                        }
                    }
                    Text("24h").font(.headline).padding(5).onTapGesture {
                        Task {
                            
                            await viewModel.changeRequestedPeriod(period: .from24);
                        }
                    }
                }.padding(.horizontal, 20).padding(.vertical, 10).font(.title)
                
                EntriesListView(viewModel: self.viewModel)
                
            }
            
            
            
            
            
        }.navigationViewStyle(.stack)
        
    }
    
    
    struct EntriesListView: View {
        
        @ObservedObject var viewModel : EntriesViewModel;
        
        
        @ViewBuilder
        var body: some View {
            
            
            List() {
                
                ForEach(viewModel.entries, id: \.id) { item in
                    
                    
                    ZStack {
                        
                        
                        EntryViewCell(entry: item).onAppear {
                            if item == self.viewModel.entries.last {
                                Task {
                                    await self.viewModel.getNextEntries()
                                }
                            }
                        }
                        
                        NavigationLink(destination:
                                        EntryDetailsView(entry:item, viewModel: self.viewModel)) {
                            EmptyView()
                        }.buttonStyle(PlainButtonStyle())
                        
                    }
                    
                    
                    
                    WykopColors.currentTheme.backgroundColor.frame( height: 20, alignment: .center).listRowInsets(EdgeInsets()).listRowSeparator(.hidden)
                    
                    
                    
                }
            }.listStyle(PlainListStyle()).refreshable {
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
                
                HStack {
                    Spacer()
                    
                    Text("+\(entry.voteCount)").foregroundColor(Color.green).padding(.trailing, 5)
                    Image(systemName:"text.bubble").modifier(BodyStyle())
                    Text("\(entry.commentsCount)")
                }
            }
            
        }.padding(0).modifier(CardStyle())
        
        
    }
    
}

struct EntryViewCellHeader : View
{
    
    var entry: Entry;
    
    var body: some View {
        HStack{
            
            AuthorView(author: entry.author)
            
        }.padding(0)
        
        
        
    }
    
}


struct EntryBodyPreview : View
{
    var entry: Entry;
    
    
    var body: some View {
        VStack{
            //            Text(entry.body ?? "")
            
            Text(entry.bodyAttributed ?? "").fixedSize(horizontal: false, vertical: true)
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
                            Image(systemName: "questionmark").modifier(BodyStyle())
                            
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
