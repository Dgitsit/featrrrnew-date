//
//  ChatService.swift
//  featrrrnew
//
//  Created by Buddie Booking on 8/10/23.
//

import Foundation
import Firebase

struct ChatService {
    static let messagesCollection = Firestore.firestore().collection("messages")
    let chatPartner: User
    
    
   func sendMessage(_ messageText: String) {
         guard let currentUid = Auth.auth().currentUser?.uid else {return}
         let chatPartnerId = chatPartner.id
         
         let currentUserRef = COLLECTION_MESSAGES.document(currentUid).collection(chatPartnerId).document()
         let chatPartnerRef = COLLECTION_MESSAGES.document(chatPartnerId).collection(currentUid)
       
       let recentCurrentUserRef = COLLECTION_MESSAGES.document(currentUid).collection("recent-messages").document(chatPartnerId)
       let recentPartnerRef = COLLECTION_MESSAGES.document(chatPartnerId).collection("recent-messages").document(currentUid)
       
         let messageId = currentUserRef.documentID
         
         let message = Message(fromId: currentUid, toId: chatPartnerId, timestamp: Timestamp(), text: messageText)
         
         guard let messageData = try? Firestore.Encoder().encode(message) else {return}
         
         currentUserRef.setData(messageData)
         chatPartnerRef.document(messageId).setData(messageData)
       
       recentCurrentUserRef.setData(messageData)
       recentPartnerRef.setData(messageData)
     }
     
      func observedMessages(completion: @escaping([Message]) -> Void) {
         guard let currentUid = Auth.auth().currentUser?.uid else {return}
         let chatPartnerId = chatPartner.id
         let query = COLLECTION_MESSAGES
            .document(currentUid)
            .collection(chatPartnerId)
            .order(by: "timestamp", descending: false)
         
         query.addSnapshotListener { snapshot, _ in
             guard let changes = snapshot?.documentChanges.filter({$0.type == .added})else {return}
             var messages = changes.compactMap({try? $0.document.data(as: Message.self)})
             
             for (index, message) in messages.enumerated() where !message.isFromCurrentUser {
                 messages[index].user = chatPartner
             }
             
             completion(messages)
         }
     }
}
