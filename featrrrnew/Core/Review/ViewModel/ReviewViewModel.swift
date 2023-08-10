//
//  ReviewViewModel.swift
//  featrrrnew
//
//  Created by Buddie Booking on 7/26/23.
//

import SwiftUI
import Firebase

@MainActor
class ReviewViewModel: ObservableObject {
    private let post: Post
    private let postId: String
    @Published var reviews = [Review]()
    
    init(post: Post) {
        self.post = post
        self.postId = post.id ?? ""
        
        Task { try await fetchReviews() }
    }
    
    func uploadReview(reviewText: String) async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let currentUser = AuthViewModel.shared.currentUser else { return }
        
        let data: [String: Any] = ["reviewOwnerUid": uid,
                                   "timestamp": Timestamp(date: Date()),
                                   "postOwnerUid": post.ownerUid,
                                   "postId": postId,
                                   "reviewText": reviewText]
        
        let _ = try? await COLLECTION_POSTS.document(postId).collection("post-reviews").addDocument(data: data)
        NotificationsViewModel.uploadNotification(toUid: self.post.ownerUid, type: .review, post: self.post)
        self.reviews.insert(Review(user: currentUser, data: data), at: 0)
    }
    
    func fetchReviews() async throws {
        let query = COLLECTION_POSTS.document(postId).collection("post-reviews").order(by: "timestamp", descending: true)
        guard let reviewSnapshot = try? await query.getDocuments() else { return }
        let documentData = reviewSnapshot.documents.compactMap({ $0.data() })
        
        for data in documentData {
            guard let uid = data ["reviewOwnerUid"] as? String else { return }
            let user = try await UserService.fetchUser(withUid: uid)
            let reviews = Review(user: user, data: data)
            self.reviews.append(reviews)
        }
    }
}

// MARK: - Deletion

/*extension ReviewViewModel {
    func deleteAllReviews() {
        COLLECTION_POSTS.getDocuments { snapshot, _ in
            guard let postIDs = snapshot?.documents.compactMap({ $0.documentID }) else { return }
            
            for id in postIDs {
                COLLECTION_POSTS.document(id).collection("post-reviews").getDocuments { snapshot, _ in
                    guard let reviewIDs = snapshot?.documents.compactMap({ $0.documentID }) else { return }
                    
                    for reviewId in reviewIDs {
                        COLLECTION_POSTS.document(id).collection("post-review").document(reviewId).delete()
                    }
                }
            }
        }
    }
}*/
