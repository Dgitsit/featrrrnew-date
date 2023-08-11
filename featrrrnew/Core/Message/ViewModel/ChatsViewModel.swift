//
//  ChatsViewModel.swift
//  featrrrnew
//
//  Created by Buddie Booking on 8/10/23.
//

import Foundation

class ChatsViewModel: ObservableObject {
    @Published var messageText = ""
    @Published var messages = [Message]()
    let service: ChatService
    
    
    init(user: User) {
        self.service = ChatService(chatPartner: user)
        observedMessages()
    }
    
    func observedMessages() {
        service.observedMessages() { messages in
            self.messages.append(contentsOf: messages)
        }
    }
    
    func sendMessage() {
       service.sendMessage(messageText)
    }
}
