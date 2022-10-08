//
//  File.swift
//  RAWG
//
//  Created by Aldi Dwiki Prahasta on 08/10/22.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    private (set) var localRealm: Realm?
    @Published var favorites = [Favorite]()
    @Published var isEmptyFavorite = true
    @Published var isFavorited = false
    
    init() {
        openRealm()
        getAllFavorite()
    }
    
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1)
            Realm.Configuration.defaultConfiguration = config
            
            localRealm = try Realm()
        } catch {
            print("Error opening realm \(error)")
        }
    }
    
    func addTask(
        id: Int,
        title: String,
        releaseDate: String,
        rating: Double,
        image: String,
        completion: @escaping () -> Void
    ) {
        if let localRealm = localRealm {
            do {
                try localRealm.write({
                    let newTask = Favorite(value: [
                        "id": id,
                        "title": title,
                        "releaseDate": releaseDate,
                        "rating": rating,
                        "image": image
                    ])
                    
                    localRealm.add(newTask)
                    completion()
                    
                    getAllFavorite()

                    print("Added new favorite to realm \(newTask)")
                })
            } catch {
                print("Error adding favorite to realm \(error)")
            }
        }
    }
    
    func getAllFavorite() {
        if let localRealm = localRealm {
            let allFavorites = localRealm.objects(Favorite.self)
            favorites = []
            
            allFavorites.forEach { favorite in
                favorites.append(favorite)
            }
            
            isEmptyFavorite = allFavorites.isEmpty
        }
    }
    
    func deleteFavorite(id: Int, onDeleted: @escaping () -> Void) {
        if let localRealm = localRealm {
            do {
                try localRealm.write({
                    let favoriteToDelete = localRealm.objects(Favorite.self).where {
                        $0.id == id
                    }
                    guard !favoriteToDelete.isEmpty else { return }
                    
                    localRealm.delete(favoriteToDelete)
                    
                    getAllFavorite()

                    onDeleted()
                    print("Deleted favorite with id \(id)")
                })
            } catch {
                print("Error deleting favorite \(id) for realm: \(error)")
            }
        }
    }
    
    func findFavorite(id: Int) {
        if favorites.first(where: {$0.id == id }) != nil {
            self.isFavorited = true
        } else {
            self.isFavorited = false
            print("favorite with id: \(id) not found")
        }
    }
}
