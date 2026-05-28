//
//  ContentView.swift
//  iOS26Test
//
//  Created by admin on 5/27/26.
//

import SwiftUI

struct ContentView: View {
    @Namespace private var animation
    @State private var showMenu: Bool = false
    @State private var searchText: String = ""
    @State private var expandMiniPlayer: Bool = false
    @State private var activeID: UUID?
    @State private var selectedType: CarouselType = .type1
    
    var body: some View {
        Group {
            if #available(iOS 26, *) {
                NativeTabView()
                    .tabBarMinimizeBehavior(.onScrollDown)
                    .tabViewBottomAccessory{
                        MiniPlayerView()
                            .matchedTransitionSource(id: "MINIPLAYER", in: animation)
                            .onTapGesture {
                                expandMiniPlayer.toggle()
                            }
                    }
            } else {
                NativeTabView()
            }
        }
        .fullScreenCover(isPresented: $expandMiniPlayer){
            ScrollView{
                
            }
            .safeAreaInset(edge: .top, spacing: 0){
                VStack(spacing: 10){
                    //Drag indicator mimic
                    Capsule()
                        .fill(.primary.secondary)
                        .frame(width: 35, height: 3)
                    
                    HStack(spacing: 0){
                        PlayerInfo(.init(width: 80, height: 80))
                        
                        Spacer(minLength: 0)
                        
                        // Expanded Actions
                        Group {
                            Button("", systemImage: "star.circle.fill"){
                                
                            }
                            Button("", systemImage: "ellipsis.circle.fill"){
                                
                            }
                        }
                        .font(.title)
                        .foregroundStyle(Color.primary, Color.primary.opacity(0.1))
                    }
                    .padding(.horizontal, 15)
                }
                .navigationTransition(.zoom(sourceID: "MINIPLAYER", in: animation))
            }
            //To avoid transparency
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.background)
        }
    }
    
    @ViewBuilder
    func NativeTabView() -> some View {
        TabView{
            Tab.init("Home", systemImage: "house.fill"){
                NavigationStack {
                    ScrollView {
                        VStack(spacing: 36){
                            let s = selectedType.settings
                            
                            CustomCarousel(config: .init(hasOpacity: s.hasOpacity, hasScale: s.hasScale, cardWidth: s.cardWidth, minCardWidth: s.minCardWidth), selection: $activeID, data: images) { item in
                                Image(item.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            }
                            .frame(height: 200)
                            
                            Picker("Carousel Type", selection: $selectedType){
                                ForEach(CarouselType.allCases, id: \.self){ type in
                                    Text(type.title).tag(type)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 20)
                    }
                    .navigationTitle("Keihatsu")
                    .navigationBarTitleDisplayMode(.automatic)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Notifications", systemImage: "bell") {
                                
                            }
                        }
                        
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Account", systemImage: "person") {
                                showMenu.toggle()
                            }
                        }
                        .matchedTransitionSource(id: "Account", in: animation)
                    }
                    .sheet(isPresented: $showMenu) {
                        Text("Account Sheet")
                            .navigationTransition(.zoom(sourceID: "Account", in: animation))
                    }
                }
                
            }
            
            Tab.init("Library", systemImage: "books.vertical"){
                NavigationStack {
                    List{
                        
                    }
                    .navigationTitle("Library")
                }
            }
            
            Tab.init("History", systemImage: "clock.arrow.circlepath"){
                NavigationStack {
                    List{
                        
                    }
                    .navigationTitle("History")
                }
            }
            
            Tab.init("Plugins", systemImage: "puzzlepiece.extension"){
                NavigationStack {
                    List{
                        
                    }
                    .navigationTitle("Plugins")
                }
            }
            
            Tab.init("Search", systemImage: "magnifyingglass", role: .search){
                NavigationStack {
                    List{
                        
                    }
                    .navigationTitle("Search")
                    .searchable(text: $searchText, placement: .toolbar, prompt: Text("Search..."))
                }
            }
        }
    }
    
    
    // Reusable Info
    @ViewBuilder
    func PlayerInfo(_ size : CGSize) -> some View{
        HStack(spacing: 12){
            RoundedRectangle(cornerRadius: size.height / 4)
                .fill(.blue.gradient)
                .frame(width: size.width, height: size.height)
            
            VStack(alignment: .leading, spacing: 6){
                Text("Pick Me Up: Infinite Gacha")
                    .font(.callout)
                
                Text("Chapter 182")
                    .font(.caption2)
                    .foregroundStyle(.gray)
            }
            .lineLimit(1)
        }
    }
    
    @ViewBuilder
    func MiniPlayerView() -> some View {
        HStack(spacing: 15) {
            PlayerInfo(.init(width: 30, height: 30))
            
            Spacer(minLength: 0)
            
            //Action Buttons
            Button {
                
            } label: {
                Image(systemName: "book.fill")
                    .contentShape(.rect)
            }
            .padding(.trailing, 10)
            
            Button {
                
            } label: {
                Image(systemName: "forward.fill")
                    .contentShape(.rect)
            }
        }
        .padding(.horizontal, 15)
    }
    
    enum CarouselType: CaseIterable, Hashable {
        case type1, type2, type3, type4
        
        var title: String {
            switch self{
            case .type1: return "Basic"
            case .type2: return "Fade"
            case .type3: return "Zoom"
            case .type4: return "Cinematic"
            }
        }
        
        var settings: (hasOpacity: Bool, hasScale: Bool, cardWidth: CGFloat, minCardWidth: CGFloat){
            switch self{
            case .type1: return (false, false, 200,30)
            case .type2: return (true, false, 200,30)
            case .type3: return (false, true, 200,30)
            case .type4: return (true, true, 200,30)
            }
        }
    }
}

#Preview {
    ContentView()
}

