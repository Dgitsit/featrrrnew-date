//
//  MessageUserService.swift
//  featrrrnew
//
//  Created by Buddie Booking on 8/10/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class MessageUserService {
    @Published var currentUser: User?
    
    static let shared = MessageUserService()
    
    func fetchMessageCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        let user = try snapshot.data(as: User.self)
        self.currentUser = user
        print("DEBUG: Current user in service is \(currentUser)")
    }
    
}
