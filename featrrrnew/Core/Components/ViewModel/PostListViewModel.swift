//
//  PostListViewModel.swift
//  featrrrnew
//
//  Created by Buddie Booking on 7/25/23.
//

import SwiftUI
import Firebase



class PostListViewModel: ObservableObject {
    @Published var posts = [Post]()
    @Published public private(set) var user: User
    private var lastDoc: QueryDocumentSnapshot?
    //private let user: User
    
    init(user: User) {
        self.user = user
        
        Task { try await fetchUserPosts(forUser: user)}
    }
    
    func fetchPosts() {
        
            Task { try await fetchUserPosts(forUser: user) }
        }
    
    
    func fetchExplorePagePosts() {
        let query = COLLECTION_POSTS.limit(to: 20).order(by: "timestamp", descending: true)
        
        if let last = lastDoc {
            let next = query.start(afterDocument: last)
            next.getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents, !documents.isEmpty else { return }
                self.lastDoc = snapshot?.documents.last
                self.posts.append(contentsOf: documents.compactMap({ try? $0.data(as: Post.self) }))
            }
        } else {
            query.getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                self.posts = documents.compactMap({ try? $0.data(as: Post.self) })
                self.lastDoc = snapshot?.documents.last
            }
        }
    }
    
    @MainActor
    func fetchUserPosts(forUser user: User) async throws {
        let posts = try await PostService.fetchUserPosts(user: user)
        self.posts = posts
    }
}
/*//import Foundation

class PostListViewModel: ObservableObject {
    private let user: User
    @Published var posts = [Post]()
    
    init(user: User) {
        self.user = user
        
        Task { try await fetchUserPosts()}
    }
    
    @MainActor
    func fetchUserPosts() async throws {
        self.posts = try await PostService.fetchUserPosts(user: user)
        
        for i in 0 ..< posts.count {
            posts[i].user = self.user
        }
    }
}*/
