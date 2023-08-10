//
//  ChatView.swift
//  featrrrnew
//
//  Created by Buddie Booking on 7/26/23.
//

import SwiftUI

struct ChatView: View {
    let user: User
    @StateObject var viewModel: ChatViewModel
    @State var messageText: String = ""
    @State private var selectedUser: User?//
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: ChatViewModel(user: user))
    }
    
    var body: some View {
        VStack {
            /*VStack {
                if let user = viewModel.message.user {
                    CircularProfileImageView(user: user)
                
                }
            }*/
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(viewModel.messages) { message in
                        MessageView(viewModel: MessageViewModel(message: message))
                    }
                }
            }.padding(.top)
            
            CustomInputView(inputText: $messageText, placeholder: "Describe expectations...", action: sendMessage)
                .padding(10)
            
        }
        .navigationTitle(user.username)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }
    
    func sendMessage() {
        viewModel.sendMessage(messageText)
        messageText = ""
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(user: dev.user)
    }
}
