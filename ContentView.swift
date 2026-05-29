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
    @State private var selectedType: CarouselType = .type3

    private var updateSections: [UpdateSection] {
        [
            UpdateSection(
                title: "Today",
                items: [
                    UpdateEntry(item: images[4], chapterLine: "Chapter 132, 135...", trailingIcon: "arrow.down.circle"),
                    UpdateEntry(item: images[0], chapterLine: "Chapter 110, 111...", trailingIcon: "arrow.down.circle"),
                    UpdateEntry(item: images[2], chapterLine: "Chapter 57, 58...", trailingIcon: "arrow.down.circle")
                ]
            ),
            UpdateSection(
                title: "Tomorrow",
                items: [
                    UpdateEntry(item: images[1], chapterLine: "Chapter 85, 86...", trailingIcon: "clock"),
                    UpdateEntry(item: images[5], chapterLine: "Chapter 92, 93...", trailingIcon: "clock")
                ]
            )
        ]
    }
    
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
                                NavigationLink(value: item) {
                                    Image(item.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .overlay(alignment: .bottomLeading) {
                                            LinearGradient(
                                                colors: [.clear, .black.opacity(0.7)],
                                                startPoint: .top,
                                                endPoint: .bottom
                                            )
                                            .overlay(alignment: .bottomLeading) {
                                                VStack(alignment: .leading, spacing: 4) {
                                                    Text(item.title)
                                                        .font(.headline)
                                                        .fontWeight(.semibold)
                                                        .foregroundStyle(.white)
                                                        .lineLimit(2)
                                                    
                                                    Text(item.metadataLine)
                                                        .font(.caption)
                                                        .foregroundStyle(.white.opacity(0.85))
                                                        .lineLimit(1)
                                                }
                                                .padding(16)
                                            }
                                        }
                                        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                                        .contentShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                                }
                                .buttonStyle(.plain)
                                .matchedTransitionSource(id: item.id, in: animation)
                            }
                            .frame(height: 250)

                            VStack(alignment: .leading, spacing: 20) {
                                HStack {
                                    Text("Updates")
                                        .font(.title3.weight(.semibold))

                                    Spacer()

                                    Image(systemName: "chevron.right")
                                        .font(.footnote.weight(.semibold))
                                        .foregroundStyle(.secondary)
                                }

                                ForEach(updateSections) { section in
                                    VStack(alignment: .leading, spacing: 12) {
                                        Text(section.title)
                                            .font(.headline)
                                            .foregroundStyle(.secondary)

                                        VStack(spacing: 12) {
                                            ForEach(section.items) { entry in
                                                NavigationLink(value: entry.item) {
                                                    HStack(spacing: 12) {
                                                        Image(entry.item.image)
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(width: 54, height: 72)
                                                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

                                                        VStack(alignment: .leading, spacing: 4) {
                                                            Text(entry.item.title)
                                                                .font(.headline)
                                                                .foregroundStyle(.primary)
                                                                .lineLimit(1)

                                                            Text(entry.chapterLine)
                                                                .font(.subheadline)
                                                                .foregroundStyle(.secondary)
                                                                .lineLimit(1)
                                                        }

                                                        Spacer(minLength: 0)

                                                        Image(systemName: entry.trailingIcon)
                                                            .font(.title3.weight(.semibold))
                                                            .foregroundStyle(.secondary)
                                                    }
                                                    .padding(.vertical, 4)
                                                }
                                                .buttonStyle(.plain)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 20)
                    }
                    .navigationTitle("Explore")
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
                    .navigationDestination(for: ImageModel.self) { item in
                        CarouselDetailView(item: item, animation: animation)
                    }
                }
                
            }
            
            Tab.init("Library", systemImage: "books.vertical"){
                NavigationStack {
                    LibraryView(animation: animation)
                }
            }
            
            Tab.init("History", systemImage: "clock.arrow.circlepath"){
                NavigationStack {
                    HistoryView()
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
            Image(images.first?.image ?? "Image4")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height)
                .clipShape(RoundedRectangle(cornerRadius: size.height / 4, style: .continuous))
            
            VStack(alignment: .leading, spacing: 6){
                Text("The Regressed Mercenary's Machinations")
                    .font(.callout)
                
                Text("Chapter 52")
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
                Image(systemName: "play.fill")
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

    struct UpdateSection: Identifiable {
        let id = UUID()
        let title: String
        let items: [UpdateEntry]
    }

    struct UpdateEntry: Identifiable {
        let id = UUID()
        let item: ImageModel
        let chapterLine: String
        let trailingIcon: String
    }
}

#Preview {
    ContentView()
}
