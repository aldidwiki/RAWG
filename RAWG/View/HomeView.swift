//
//  HomeView.swift
//  RAWG
//
//  Created by Aldi Dwiki Prahasta on 08/10/22.
//

import SwiftUI

struct HomeView: View {
    private let networkService = NetworkService()
    
    @EnvironmentObject var realmManager: RealmManager
    
    @State var games = [Game]()
    @State var isLoading = true
    @State var isError = false
    @State var searchFor = ""
    
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
            }.onChange(of: searchFor, perform: { _ in
                Task {
                    isLoading = true
                    do {
                        if searchFor.isEmpty {
                            self.games = try await networkService.getGames()
                        } else {
                            self.games = try await networkService.getGames(searchQuery: searchFor)
                        }
                        isLoading = false
                        isError = false
                    } catch {
                        isLoading = false
                        isError = true
                    }
                }
            }).task {
                isLoading = true
                do {
                    if searchFor.isEmpty {
                        self.games = try await networkService.getGames()
                    } else {
                        self.games = try await networkService.getGames(searchQuery: searchFor)
                    }
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
        }.searchable(text: $searchFor, placement: .automatic)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(RealmManager())
    }
}
