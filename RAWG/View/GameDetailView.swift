//
//  GameDetailView.swift
//  RAWG
//
//  Created by Aldi Dwiki Prahasta on 08/10/22.
//

import SwiftUI

struct GameDetailView: View {
    var gameId: Int
    
    @EnvironmentObject var realmManager: RealmManager
    
    @State var gameDetail: GameDetail
    @State var isLoading = true
    @State var isError = false
    @State private var isFavorite = false
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading Detail...")
            } else {
                ScrollView {
                    VStack {
                        AsyncImage(url: gameDetail.imageUrl) { Image in
                            Image.resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        
                        Text(gameDetail.title)
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                            .padding(.top, 10)
                        
                        Text(self.formattedDate())
                            .font(.system(size: 18))
                        
                        Text(String(gameDetail.rating))
                            .padding(.top, 20)
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                        
                        Text(gameDetail.description)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.top, 20)
                        
                        Spacer()
                    }.padding()
                }
            }
        }.task {
            let networkService = NetworkService()
            isLoading = true
            do {
                gameDetail = try await networkService.getGameDetail(gameId: gameId)
                isLoading = false
                isError = false
                
                realmManager.findFavorite(id: gameId)
                isFavorite = realmManager.isFavorited
            } catch {
                isLoading = false
                isError = true
            }
        }.alert("Failed load data!", isPresented: $isError) {
            Button("OK", role: .cancel) {}
        }.toolbar {
            ToolbarItem {
                Button {
                    if isFavorite {
                        realmManager.deleteFavorite(id: gameId) {
                            self.isFavorite.toggle()
                        }
                    } else {
                        realmManager.addTask(
                            id: gameId,
                            title: gameDetail.title,
                            releaseDate: formattedDate(),
                            rating: gameDetail.rating,
                            image: gameDetail.imageUrl.absoluteString
                        ) {
                            self.isFavorite.toggle()                    }
                    }
                } label: {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                }.disabled(isLoading)
                
            }
        }
    }
    
    private func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter.string(from: gameDetail.releaseDate)
    }
}

struct GameDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailView(gameId: 3498,gameDetail: gameDetail)
            .environmentObject(RealmManager())
    }
}
