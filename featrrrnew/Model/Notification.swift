//
//  Notification.swift
//  featrrrnew
//
//  Created by Buddie Booking on 7/26/23.
//

import FirebaseFirestoreSwift
import Firebase

struct Notification: Identifiable, Decodable {
    @DocumentID var id: String?
    var postId: String?
    let timestamp: Timestamp
    let type: NotificationType
    let uid: String
    
   
    var post: Post?
    var user: User?
}

enum NotificationType: Int, Decodable {
    case review
    
    var notificationMessage: String {
        switch self {
        case .review: return " left a review on your post."
        }
    }
}
