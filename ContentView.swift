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
        case .library: return "books"
        case .history: return "clock"
        case .extensions: return "puzzlepiece"
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
            .navigationTitle("AstridOS")
            .navigationSubtitle("SurfUIKit for AstridOS")
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
            HStack (spacing: 10) {
                GeometryReader{
                    CustomTabBar(size: $0.size, activeTab: $activeTab) {
                        tab in
                    }
                }
            }
            .frame(height: 55)
        }
        .padding(.horizontal, 20)

    }
}

#Preview {
    ContentView()
}


