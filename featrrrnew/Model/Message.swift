//
//  Message.swift
//  featrrrnew
//
//  Created by Buddie Booking on 7/25/23.
//

import FirebaseFirestoreSwift
import Firebase

struct Message: Identifiable, Hashable, Codable { //change Codable to Decodable 
    @DocumentID var messageId: String?//
    //let id: String
    let fromId: String
    let toId: String
    let timestamp: Timestamp
    let text: String
    
    var user: User?
    
    var id: String {
        return messageId ?? NSUUID().uuidString
    }//
    
    var chatPartnerId: String { return fromId == Auth.auth().currentUser?.uid ? toId : fromId }
    
    var isFromCurrentUser: Bool {
        return fromId == Auth.auth().currentUser?.uid
    }//
}
