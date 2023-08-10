//
//  MessageService.swift
//  featrrrnew
//
//  Created by Buddie Booking on 8/8/23.
//

import Foundation
import Firebase

struct MessageService {
    
   static let messagesCollection = Firestore.firestore().collection("messages")
    
   static func sendMessage(_ messageText: String, toUser user: User) {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        let chatPartnerId = user.id
        
        let currentUserRef = messagesCollection.document(currentUid).collection(chatPartnerId).document()
        let chatPartnerRef = messagesCollection.document(chatPartnerId).collection(currentUid)
        
        let messageId = currentUserRef.documentID
        
        let message = Message(fromId: currentUid, toId: chatPartnerId, timestamp: Timestamp(), text: messageText)
        
        guard let messageData = try? Firestore.Encoder().encode(message) else {return}
        
        currentUserRef.setData(messageData)
        chatPartnerRef.document(messageId).setData(messageData)
    }
}
