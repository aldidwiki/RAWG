//
//  ImageDownloader.swift
//  GameCatalogue
//
//  Created by Aldi Dwiki Prahasta on 27/09/22.
//

import UIKit

class ImageDownloader {
    func downloadImage(url: URL) async throws -> UIImage {
        async let imageData: Data = try Data(contentsOf: url)
        return UIImage(data: try await imageData)!
    }
}
