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
            AsyncImage(url: game.imageUrl) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }.frame(width: 100, height: 100)
            
            VStack(alignment: .leading) {
                Text(game.title)
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .lineLimit(2)
                
                Text(game.releaseDate.formatDateToString(format: "dd MMM yyyy"))
            }
            .padding(.leading)
            
            Spacer()
            Text(String(game.rating))
        }
    }
}

struct GameItemView_Previews: PreviewProvider {
    static var previews: some View {
        GameItemView(game: game)
    }
}
