//
//  ChatsView.swift
//  featrrrnew
//
//  Created by Buddie Booking on 8/9/23.
//

import SwiftUI

struct ChatsView: View {
    @StateObject var viewModel: ChatsViewModel
    let user: User
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: ChatsViewModel(user: user))
    }
    //@State private var messageText = ""
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
                
                ForEach(viewModel.messages) { message in
                    ChatsMessageCell(message: message, user: user)
                }
            }
            
            ZStack(alignment: .trailing) {
                TextField("Detail your vision..", text: $viewModel.messageText, axis: .vertical)
                    .padding(12)
                    .padding(.trailing, 40)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(Capsule())
                    .font(.subheadline)
                
                Button {
                    viewModel.sendMessage()
                    viewModel.messageText = ""
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
