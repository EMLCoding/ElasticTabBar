//
//  ContentView.swift
//  ElasticTabBar
//
//  Created by Eduardo Martin Lorenzo on 20/6/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentTab: Tab = .Home
    
    @Namespace var animation
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let bottomEdge = proxy.safeAreaInsets.bottom
            
            ZStack(alignment: .bottom) {
                TabView(selection: $currentTab) {
                    Text("Home")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.04).ignoresSafeArea())
                        .tag(Tab.Home)
                    
                    Text("Search")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.04).ignoresSafeArea())
                        .tag(Tab.Search)
                    
                    Text("Liked")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.04).ignoresSafeArea())
                        .tag(Tab.Liked)
                    
                    Text("Settings")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.04).ignoresSafeArea())
                        .tag(Tab.Settings)
                }
                
                CustomTab(currentTab: $currentTab, animation: animation, size: size, bottomEdge: bottomEdge)
                    .background(Color.white)
            }
            .ignoresSafeArea(.all, edges: .bottom )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
