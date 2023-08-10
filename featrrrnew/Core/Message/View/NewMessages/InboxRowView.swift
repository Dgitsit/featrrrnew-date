//
//  ActiveNowView.swift
//  featrrrnew
//
//  Created by Buddie Booking on 8/9/23.
//

import SwiftUI

struct InboxRowView: View {
    let user: User
    var body: some View {
        HStack {
            CircularProfileImageView(user: user)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Hef")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text("Yo Featrrr Featrrr im tryna do a featrrr w you")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                    .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
            }
            
            HStack {
                Text("Yesterday")
                
                Image(systemName: "chevron.right")
            }
            .font(.footnote)
            .foregroundColor(.gray)
        }
        .padding(.horizontal)
        .frame(height: 72)
    }
}

struct InboxRowView_Previews: PreviewProvider {
    static var previews: some View {
        InboxRowView(user: dev.user)
    }
}
