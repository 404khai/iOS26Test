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
        
        Group {
            if #available(iOS 26, *) {
                NativeTabView()
            } else {
                NativeTabView()
            }
        }
    }
    
    @ViewBuilder
    func NativeTabView() -> some View {
        TabView{
            Tab.init("Home", systemImage: "house.fill"){
                NavigationStack {
                    List{
                        
                    }
                    .navigationTitle("Keihatsu")
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
                }
            }
        }
    }
    
}

#Preview {
    ContentView()
}


