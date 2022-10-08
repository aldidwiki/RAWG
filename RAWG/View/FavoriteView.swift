//
//  FavoriteView.swift
//  RAWG
//
//  Created by Aldi Dwiki Prahasta on 08/10/22.
//

import SwiftUI

struct FavoriteView: View {
    @EnvironmentObject var realmManager: RealmManager
    
    var body: some View {
        NavigationView {
            ZStack {
                List(realmManager.favorites) { favorite in
                    if !favorite.isInvalidated {
                        NavigationLink {
                            GameDetailView(gameId: favorite.id, gameDetail: gameDetail)
                        } label: {
                            GameItemView(game: favorite.toGameModel())
                        }
                    }
                }
                
                if realmManager.isEmptyFavorite {
                    Text("No Favorite Found")
                        .font(.system(size: 24))
                }
            }.navigationTitle("Favorite Game")
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
            .environmentObject(RealmManager())
    }
}
