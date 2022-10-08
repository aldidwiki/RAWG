//
//  ContentView.swift
//  RAWG
//
//  Created by Aldi Dwiki Prahasta on 08/10/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var realmManager: RealmManager = RealmManager()
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .environmentObject(realmManager)
            
            FavoriteView()
                .tabItem {
                    Label("Favorite", systemImage: "heart")
                }
                .environmentObject(realmManager)
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
