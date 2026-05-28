//
//  ContentView.swift
//  iOS26Test
//
//  Created by admin on 5/27/26.
//

import SwiftUI

struct ContentView: View {
    @Namespace private var animation
    
    var body: some View {
        NavigationStack {
            List{
                
            }
            .navigationTitle("AstridOS")
            .navigationSubtitle("SurfUIKit for AstridOS")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Settings", systemImage: "bell") {
                        
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Account", systemImage: "person") {
                        
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
