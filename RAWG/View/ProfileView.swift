//
//  ProfileView.swift
//  RAWG
//
//  Created by Aldi Dwiki Prahasta on 08/10/22.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            Image("profile_pic")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250, height: 250)
            
            Text("Aldi Dwiki Prahasta")
                .fontWeight(.bold)
                .font(.system(size: 24))
                .padding(.top, 16.0)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
