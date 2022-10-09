//
//  GameModel.swift
//  GameCatalogue
//
//  Created by Aldi Dwiki Prahasta on 27/09/22.
//

import UIKit

enum DownloadState {
    case new, downloaded, failed
}

class Game: Identifiable {
    let id: Int
    let title: String
    let rating: Double
    let imageUrl: URL
    let releaseDate: Date
    
    var image: UIImage?
    var state: DownloadState = .new
    
    init(title: String, rating: Double, imageUrl: URL, releaseDate: Date, id: Int) {
        self.title = title
        self.rating = rating
        self.imageUrl = imageUrl
        self.releaseDate = releaseDate
        self.id = id
    }
}

struct GameResponse: Codable {
    let games: [GameResponseModel]
    
    enum CodingKeys: String, CodingKey {
        case games = "results"
    }
}

struct GameResponseModel: Codable {
    let id: Int
    let imageUrl: URL
    let title: String
    let releaseDate: Date
    let rating: Double
    
    enum CodingKeys: String, CodingKey {
        case title = "name"
        case releaseDate = "released"
        case imageUrl = "background_image"
        case rating
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try container.decode(String.self, forKey: .title)
        self.rating = try container.decode(Double.self, forKey: .rating)
        self.id = try container.decode(Int.self, forKey: .id)
        
        let url = try container.decode(String.self, forKey: .imageUrl)
        self.imageUrl = URL(string: url)!
        
        let dateString = try container.decode(String.self, forKey: .releaseDate)
        self.releaseDate = dateString.formatStringToDate(format: "yyyy-MM-dd")
    }
}

let game = Game(
    title: "Grand Theft Auto V",
    rating: 4.2,
    imageUrl: URL(string: "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg")!,
    releaseDate: Date(),
    id: 12
)
