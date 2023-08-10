//
//  RoundedRectangleView.swift
//  featrrrnew
//
//  Created by Buddie Booking on 7/24/23.
//

import SwiftUI
import Kingfisher

struct RoundedRectangleView: View {
    let user: User
    var body: some View {
        if let imageUrl = user.profileImageUrl {
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 370, height: 350)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 370, height: 350)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundColor(Color(.systemGray4))
        }
    }
}

struct RoundedRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRectangleView(user: dev.user)
    }
}
