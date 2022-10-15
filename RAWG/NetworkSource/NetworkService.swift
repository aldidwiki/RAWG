//
//  NetworkService.swift
//  GameCatalogue
//
//  Created by Aldi Dwiki Prahasta on 27/09/22.
//

import Foundation

class NetworkService {
    let apiKey = "bc5e5774b10d40f7b8768e231b155c65"
    let page = "1"
    let pageSize = "15"
    
    func getGames(searchQuery: String? = nil) async throws -> [Game] {
        var components = URLComponents(string: "https://api.rawg.io/api/games")!
        components.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "page", value: page),
            URLQueryItem(name: "page_size", value: pageSize),
            URLQueryItem(name: "search", value: searchQuery)
        ]
        
        let request = URLRequest(url: components.url!)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error: Can't fetching data.")
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(GameResponse.self, from: data)
        
        return gameMapper(input: result.games)
    }
    
    func getGameDetail(gameId: Int) async throws -> GameDetail {
        var components = URLComponents(string: "https://api.rawg.io/api/games/\(gameId)")!
        components.queryItems = [
            URLQueryItem(name: "key", value: apiKey)
        ]
        
        let request = URLRequest(url: components.url!)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error: Can't fetching data.")
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(GameDetailResponse.self, from: data)
        
        return gameDetailMapper(input: result)
    }
}

extension NetworkService {
    fileprivate func gameMapper(input gameResponse: [GameResponseModel]) -> [Game] {
        return gameResponse.map { result in
            return Game(
                title: result.title,
                rating: result.rating,
                imageUrl: result.imageUrl,
                releaseDate: result.releaseDate,
                id: result.id
            )
        }
    }
    
    fileprivate func gameDetailMapper(input gameDetailResponse: GameDetailResponse) -> GameDetail {
        return GameDetail(
            title: gameDetailResponse.title,
            releaseDate: gameDetailResponse.releaseDate,
            description: gameDetailResponse.description,
            imageUrl: gameDetailResponse.imageUrl,
            rating: gameDetailResponse.rating
        )
    }
}
