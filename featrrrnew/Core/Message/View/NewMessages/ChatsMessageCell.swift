//
//  ChatsMessageCell.swift
//  featrrrnew
//
//  Created by Buddie Booking on 8/10/23.
//

import SwiftUI

struct ChatsMessageCell: View {
    let message: Message
    let user: User
    private var isFromCurrentUser: Bool {
        return message.isFromCurrentUser
    }
    var body: some View {
        HStack {
            if isFromCurrentUser {
                Spacer()
                Text(message.text)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemPurple))
                    .foregroundColor(.white)
                    .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                    .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
            } else {
                HStack(alignment: .bottom, spacing: 8) {
                    CircularProfileImageView(user: user)
                    
                    Text(message.text)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray5))
                        .foregroundColor(.black)
                        .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                        .frame(maxWidth: UIScreen.main.bounds.width / 1.75, alignment: .leading)
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 8)
    }
}

//struct ChatsMessageCell_Previews: PreviewProvider {
   // static var previews: some View {
       // ChatsMessageCell(isFromCurrentUser: false, user: dev.user)
   // }
//}
