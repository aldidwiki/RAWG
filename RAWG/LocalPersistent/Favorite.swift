//
//  Task.swift
//  RAWG
//
//  Created by Aldi Dwiki Prahasta on 08/10/22.
//

import Foundation
import RealmSwift

class Favorite: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title: String
    @Persisted var releaseDate: Date
    @Persisted var rating: Double
    @Persisted var image: String
    
    func toGameModel() -> Game {
        return Game(
            title: title,
            rating: rating,
            imageUrl: URL(string: image)!,
            releaseDate: releaseDate,
            id: self.id)
    }
}
