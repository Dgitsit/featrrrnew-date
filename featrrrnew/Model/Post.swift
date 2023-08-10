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
    var user: User?
    
    
}

/*struct Post: Identifiable, Hashable, Codable {
    let id: String
    let ownerUid: String
    let postBio: String
    var rating: Int
    let postImageUrl: String
    let timestamp: Timestamp
    let hr: Int
    let task: Int
    let storyPost: Int
    let city: String
    let state: String
    let country: String
    let category: String
    var user: User?
    
}

extension Post {
    static var MOCK_POST: [Post] = [
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, postBio: "greatest there is", rating: 0, postImageUrl: "model", timestamp: Timestamp(), hr: 310, task: 70, storyPost: 32, city: "Manhattan", state: "NY", country: "US", category: "model", user: User.MOCK_USERS[4]),
        
            .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, postBio: "through my eye", rating: 0, postImageUrl: "photographer", timestamp: Timestamp(), hr: 210, task: 100, storyPost: 80, city: "Atlanta", state: "GA", country: "US", category: "photographer", user: User.MOCK_USERS[1]),
        
            .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, postBio: "lemme see", rating: 0, postImageUrl: "videographer", timestamp: Timestamp(), hr: 150, task: 100, storyPost: 20, city: "Houston", state: "TX", country: "US", category: "videographer", user: User.MOCK_USERS[2]),
        
            .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, postBio: "watch me", rating: 0, postImageUrl: "malemodel", timestamp: Timestamp(), hr: 180, task: 110, storyPost: 40, city: "Philadelphia", state: "PA", country: "US", category: "male model", user: User.MOCK_USERS[0]),
        
            .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, postBio: "video perfect", rating: 0, postImageUrl: "videovixen", timestamp: Timestamp(), hr: 325, task: 135, storyPost: 65, city: "Miami", state: "FL", country: "US", category: "video vixen", user: User.MOCK_USERS[3]),
    ]
}*/
