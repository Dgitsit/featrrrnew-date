//
//  User.swift
//  featrrrnew
//
//  Created by Buddie Booking on 6/29/23.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct User: Identifiable, Codable {
    @DocumentID var uid: String?
    var username: String
    let email: String
    var profileImageUrl: String?
    var fullname: String?
    var bio: String?
    var isFollowed: Bool? = false
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == id }
    var id: String { return uid ?? NSUUID().uuidString }
}

extension User: Hashable {
    var identifier: String { return id }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}

/*struct User: Identifiable, Hashable, Codable {
    let id: String
    var username: String
    var profileImageUrl: String?
    var fullname: String?
    var bio: String?
    let email: String
    
    var isCurrentUser: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else {return false}
        return currentUid == id
    }
    //var userPost: [Post]?
}

extension User {
    static var MOCK_USERS: [User] = [
        .init(id: NSUUID().uuidString, username: "malemodel", profileImageUrl: nil, fullname: "NoEqual Banko", bio: "banks bio", email: "bank@gmail.com"),
        
            .init(id: NSUUID().uuidString, username: "photographer", profileImageUrl: nil, fullname: "NoEqual FH YM", bio: "ym bio", email: "ym@gmail.com"),
        
            .init(id: NSUUID().uuidString, username: "videographer", profileImageUrl: nil, fullname: "NoEqual Tro", bio: "tro bio", email: "tro@gmail.com"),
        

        
        .init(id: NSUUID().uuidString, username: "model", profileImageUrl: nil, fullname: "NoEqual Monty", bio: "monty bio", email: "monty@gmail.com")
    ]
}*/
