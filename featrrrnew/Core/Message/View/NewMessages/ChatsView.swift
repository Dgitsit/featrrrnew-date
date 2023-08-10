//
//  ChatsView.swift
//  featrrrnew
//
//  Created by Buddie Booking on 8/9/23.
//

import SwiftUI

struct ChatsView: View {
    let user: User
    @State private var messageText = ""
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    CircularProfileImageView(user: user)
                    
                    VStack(spacing: 4) {
                        Text("Banks")
                            .font(.title)
                            .fontWeight(.semibold)
                        
                        Text("Messenger")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                
                ForEach(0 ... 15, id: \.self) { message in
                    ChatsMessageCell(isFromCurrentUser: Bool.random(), user: user)
                }
            }
            
            ZStack(alignment: .trailing) {
                TextField("Detail your vision..", text: $messageText, axis: .vertical)
                    .padding(12)
                    .padding(.trailing, 40)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(Capsule())
                    .font(.subheadline)
                
                Button {
                    print("send message")
                } label: {
                    Text("Send")
                        .fontWeight(.semibold)
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }
}

struct ChatsView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsView(user: dev.user)
    }
}
