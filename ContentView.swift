//
//  ContentView.swift
//  iOS26Test
//
//  Created by admin on 5/27/26.
//

import SwiftUI

// Tab Items
enum CustomTab: String, CaseIterable{
    case home = "Home"
    case library = "Library"
    case history = "History"
    case extensions = "Extensions"
    
    var symbol: String {
        switch self {
        case .home: return "house"
        case .library: return "books.vertical"
        case .history: return "clock.arrow.circlepath"
        case .extensions: return "puzzlepiece.extension"
        }
    }
    
    var actionSymbol: String {
        switch self {
        case .home: return "house"
        case .library: return "books.vertical"
        case .history: return "clock.arrow.circlepath"
        case .extensions: return "puzzlepiece.extension"
        }
    }
    
    var index: Int {
        Self.allCases.firstIndex(of: self) ?? 0
    }
}

struct ContentView: View {
    @Namespace private var animation
    @State private var showMenu: Bool = false
    @State private var showShareOptions: Bool = false
    @State private var activeTab: CustomTab = .home
    
    var body: some View {
        NavigationStack {
            List{
                
            }
            .navigationTitle("Keihatsu")
//            .navigationSubtitle("SurfUIKit for AstridOS")
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
        
        VStack {
            GlassEffectContainer(spacing: 10){
                HStack (spacing: 10) {
                    GeometryReader{
                        CustomTabBar(size: $0.size, activeTab: $activeTab) { tab in
                            VStack (spacing: 3) {
                                Image(systemName: tab.symbol)
                                    .font(.title3)
                                
                                Text(tab.rawValue)
                                    .font(.system(size: 10))
                                    .fontWeight(.medium)
                            }
                            .symbolVariant(.fill)
                            .frame(maxWidth: .infinity)
                        }
                        .glassEffect(.regular.interactive(), in: .capsule)
                    }
                }
                
                ZStack {
                    ForEach(CustomTab.allCases, id: \.rawValue){
                        tab in
                        Image(systemName: tab.actionSymbol)
                            .font(.system(size: 22, weight: .medium))
                            .blurFade(activeTab == tab)
                    }
                    .frame(width: 55, height: 55)
                    .glassEffect(.regular.interactive(), in: .capsule)
                    .animation(.smooth(duration: 0.55, extraBounce: 0), value: activeTab)
                }
            }
            .frame(height: 55)
        }
        .padding(.horizontal, 20)

    }
}

// Blur Fade In/Out
extension View {
    @ViewBuilder
    func blurFade (_ status: Bool) -> some View {
        self
            .compositingGroup()
            .blur(radius: status ? 0 : 10)
            .opacity(status ? 1 : 0)
    }
}

#Preview {
    ContentView()
}


