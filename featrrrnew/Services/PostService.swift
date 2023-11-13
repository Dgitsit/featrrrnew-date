//
//  PostService.swift
//  featrrrnew
//
//  Created by Buddie Booking on 7/25/23.
//

import Foundation
import Firebase

struct PostService {
    
    static func fetchPost(withId id: String) async throws -> Post {
        let postSnapshot = try await COLLECTION_POSTS.document(id).getDocument()
        let post = try postSnapshot.data(as: Post.self)
        return post
    }
    
    static func fetchUserPosts(user: User) async throws -> [Post] {
        let snapshot = try await COLLECTION_POSTS.whereField("ownerUid", isEqualTo: user.id).getDocuments()
       
        var posts = snapshot.documents.compactMap({try? $0.data(as: Post.self )})
        
        for i in 0 ..< posts.count {
            
            posts[i].user = user
        }
        
        return posts
    }
}

/*import Firebase

struct PostService {
    
    private static let postsCollection = Firestore.firestore().collection("posts")
    
    static func fetchFeedPosts() async throws -> [Post] {
        let snapshot = try await postsCollection.getDocuments()
        var posts = try snapshot.documents.compactMap({ try $0.data(as: Post.self)})
        
        for i in 0 ..< posts.count {
            let post = posts[i]
            let ownerUid = post.ownerUid
            let postUser = try await UserService.fetchUser(withUid: ownerUid)
            posts[i].user = postUser
        }
        return posts
    }
    
    static func fetchUsersPosts(uid: String) async throws -> [Post]{
        let snapshot = try await postsCollection.whereField("ownerUid", isEqualTo: uid).getDocuments()
        return try snapshot.documents.compactMap({ try $0.data(as: Post.self)})
    }
}*/
