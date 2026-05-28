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
    @State private var showShareOptions: Bool = false
    
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
                    
                ToolbarItem(placement: .bottomBar) {
                    Button("Share", systemImage: "square.and.arrow.up"){
                        showShareOptions.toggle()
                    }
                }
                .matchedTransitionSource(id: "Share", in: animation)
                    
                ToolbarSpacer(.flexible, placement: .bottomBar)
                    
                ToolbarItem(placement: .bottomBar) {
                    Button("Clipboard", systemImage: "paperclip"){
                            
                    }
                }
                    
                ToolbarItem(placement: .bottomBar) {
                    Button("Write", systemImage: "square.and.pencil"){
                            
                    }
                }
            }
            .sheet(isPresented: $showMenu) {
                Text("Account Sheet")
                    .navigationTransition(.zoom(sourceID: "Account", in: animation))
            }
            .sheet(isPresented: $showShareOptions) {
                Text("Share Options")
                    .navigationTransition(.zoom(sourceID: "Share", in: animation))
                    .presentationDetents([.height(350)])
            }

        }

    }
}

#Preview {
    ContentView()
}


