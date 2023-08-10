//
//  UploadPostViewModel.swift
//  featrrrnew
//
//  Created by Buddie Booking on 7/10/23.
//

//import Foundation
import PhotosUI
import SwiftUI
import Firebase

@MainActor
class UploadPostViewModel: ObservableObject {
    @Published var didUploadPost = false
    @Published var error: Error?
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage(fromItem: selectedImage) } }
    }
    @Published var imageUrl: Image?
    private var uiImage: UIImage?
    
    func uploadPost(postBio: String, hr: Int, task: Int, storyPost: Int, city: String, state: String, country: String, category: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let image = uiImage else { return }
        
        do {
            guard let imageUrl = try await ImageUploader.uploadImage(image: image, type: .post) else { return }
            let data: [String: Any] = [
                "postBio": postBio,
                "hr": hr,
                "task": task,
                "storyPost": storyPost,
                "category": category,
                "city": city,
                "state": state,
                "country": country,
                "timestamp": Timestamp(date: Date()),
                "imageUrl": imageUrl,
                "ownerUid": uid
            ]
            
            let _ = try await COLLECTION_POSTS.addDocument(data: data)
            self.didUploadPost = true
        } catch {
            print("DEBUG: Failed to upload image with error \(error.localizedDescription)")
            self.error = error
        }
    }
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.imageUrl = Image(uiImage: uiImage)

    }
}
/*@MainActor
class UploadPostViewModel: ObservableObject {
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage(fromItem: selectedImage) }}
    }
    @Published var postImageUrl: Image?
    private var uiImage: UIImage?
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
        guard let uiImage = UIImage(data: data) else {return}
        self.uiImage = uiImage
        self.postImageUrl = Image(uiImage: uiImage)
    }
    
    func uploadPost(postBio: String, hr: Int, task: Int, storyPost: Int, city: String, state: String, country: String, category: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let uiImage = uiImage else {return}
        
        let postRef = Firestore.firestore().collection("posts").document()
        guard let imageUrl = try await ImageUploader.uploadImage(image: uiImage) else {return}
        let post = Post(id: postRef.documentID, ownerUid: uid, postBio: postBio, rating: 0, postImageUrl: imageUrl, timestamp: Timestamp(), hr: hr, task: task, storyPost: storyPost, city: city, state: state, country: country, category: category)
        guard let encodedPost = try? Firestore.Encoder().encode(post) else {return}
        
        try await postRef.setData(encodedPost)
    }
    
 func uploadPost(postBio: String, hr: Int, task: Int, storyPost: Int, city: String, state: String, country: String, category: String) async throws {
     guard let uid = Auth.auth().currentUser?.uid else { return }
     guard let image = uiImage else { return }
     
     do {
         guard let imageUrl = try await ImageUploader.uploadImage(image: image) else { return }
         let data: [String: Any] = [
             "postBio": postBio,
             "hr": hr,
             "task": task,
             "storyPost": storyPost,
             "category": category,
             "city": city,
             "state": state,
             "country": country,
             "timestamp": Timestamp(date: Date()),
             "imageUrl": imageUrl,
             "ownerUid": uid
         ]
         
         let _ = try await COLLECTION_POSTS.addDocument(data: data)
         self.didUploadPost = true
     } catch {
         print("DEBUG: Failed to upload image with error \(error.localizedDescription)")
         self.error = error
     }
 }
 
}*/


