//
//  HomeView.swift
//  RAWG
//
//  Created by Aldi Dwiki Prahasta on 08/10/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var realmManager: RealmManager
    
    @State var games = [Game]()
    @State var isLoading = true
    @State var isError = false
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView("Loading... Please Wait.")
                } else {
                    List(games) { game in
                        NavigationLink {
                            GameDetailView(gameId: game.id, gameDetail: gameDetail)
                                .environmentObject(realmManager)
                        } label: {
                            GameItemView(game: game)
                        }
                    }
                }
            }.task {
                let networkService = NetworkService()
                isLoading = true
                do {
                    self.games = try await networkService.getGames()
                    isLoading = false
                    isError = false
                } catch {
                    isLoading = false
                    isError = true
                }
            }.alert("Failed load data!", isPresented: $isError) {
                Button("OK", role: .cancel) {}
            }
            .navigationTitle("Popular Games")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(RealmManager())
    }
}
