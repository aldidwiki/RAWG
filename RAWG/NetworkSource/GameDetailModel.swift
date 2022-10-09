//
//  GameDetailModel.swift
//  GameCatalogue
//
//  Created by Aldi Dwiki Prahasta on 27/09/22.
//

import UIKit

class GameDetail: Identifiable {
    let title: String
    let releaseDate: Date
    let description: String
    let imageUrl: URL
    let rating: Double
    
    var image: UIImage?
    var state: DownloadState = .new
    
    init(title: String, releaseDate: Date, description: String, imageUrl: URL, rating: Double) {
        self.title = title
        self.releaseDate = releaseDate
        self.description = description
        self.imageUrl = imageUrl
        self.rating = rating
    }
}

struct GameDetailResponse: Codable {
    let title: String
    let releaseDate: Date
    let imageUrl: URL
    let description: String
    let rating: Double
    
    enum CodingKeys: String, CodingKey {
        case title = "name"
        case releaseDate = "released"
        case imageUrl = "background_image"
        case description = "description_raw"
        case rating
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        
        let url = try container.decode(String.self, forKey: .imageUrl)
        self.imageUrl = URL(string: url)!
        
        let dateString = try container.decode(String.self, forKey: .releaseDate)
        self.releaseDate = dateString.formatStringToDate(format: "yyyy-MM-dd")
        
        self.rating = try container.decode(Double.self, forKey: .rating)
    }
}

let gameDetail = GameDetail(
    title: "Grand Theft Auto V",
    releaseDate: Date(),
    description: """
Rockstar Games went bigger, since their previous installment of the series. You get the complicated and realistic world-building from Liberty City of GTA4 in the setting of lively and diverse Los Santos, from an old fan favorite GTA San Andreas. 561 different vehicles (including every transport you can operate) and the amount is rising with every update. \nSimultaneous storytelling from three unique perspectives: \nFollow Michael, ex-criminal living his life of leisure away from the past, Franklin, a kid that seeks the better future, and Trevor, the exact past Michael is trying to run away from. \nGTA Online will provide a lot of additional challenge even for the experienced players, coming fresh from the story mode. Now you will have other players around that can help you just as likely as ruin your mission. Every GTA mechanic up to date can be experienced by players through the unique customizable character, and community content paired with the leveling system tends to keep everyone busy and engaged.
""",
    imageUrl: URL(string: "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg")!,
    rating: 2.4
)
