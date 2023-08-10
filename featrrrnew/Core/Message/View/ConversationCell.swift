//
//  ConversationCell.swift
//  featrrrnew
//
//  Created by Buddie Booking on 7/26/23.
//

import SwiftUI
import Kingfisher

struct ConversationCell: View {
    let message: Message
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 12) {
                if let user = message.user {
                    CircularProfileImageView(user: user)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    if let user = message.user {
                        Text(user.fullname ?? "")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    
                    Text(message.text)
                        .font(.system(size: 15))
                        .lineLimit(2)
                }
                .foregroundColor(.black)
                .padding(.trailing)
                
                Spacer()
            }
            
            Divider()
        }
        
    }
}
