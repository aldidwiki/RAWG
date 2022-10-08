//
//  GameItemView.swift
//  RAWG
//
//  Created by Aldi Dwiki Prahasta on 08/10/22.
//

import SwiftUI

struct GameItemView: View {
    var game: Game
    
    var body: some View {
        HStack {
            AsyncImage(url: game.imageUrl) { Image in
                Image.resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }.frame(width: 100, height: 100)
            
            VStack(alignment: .leading) {
                Text(game.title)
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .lineLimit(2)
                
                Text(self.formattedDate())
            }
            .padding(.leading)
            
            Spacer()
            Text(String(game.rating))
        }
    }
    
    private func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: game.releaseDate)
    }
}

struct GameItemView_Previews: PreviewProvider {
    static var previews: some View {
        GameItemView(game: game)
    }
}
