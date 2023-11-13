//
//  Post.swift
//  featrrrnew
//
//  Created by Buddie Booking on 6/29/23.
//

import FirebaseFirestoreSwift
import Firebase

struct Post: Identifiable, Hashable, Decodable {
    @DocumentID var id: String?
    let ownerUid: String
    let postBio: String
    var rating: Int?
    let imageUrl: String
    let timestamp: Timestamp
    let hr: Int
    let task: Int
    let storyPost: Int
    let city: String
    let state: String
    let country: String
    let category: String
    let paidUsers: [String]?
    let refundRequestedUsers: [String]?
//    let :[String]
    var user: User?
    
    
}
