//
//  EditPostViewModel.swift
//  featrrrnew
//
//  Created by admin on 8/3/23.
//

import Foundation
import PhotosUI
import SwiftUI
import Firebase

@MainActor
class EditPostViewModel: ObservableObject {
    @Published public private(set) var isBusy = false
    @Published public private(set) var errorMsg: String?
    @Published public private(set) var post: Post
    //@Published public private(set) var user: User//
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage(fromItem: selectedImage) } }
    }
    @Published var imageUrl: Image?
    private var uiImage: UIImage?
    
    init(post: Post) {
        self.post = post
        //self.user = user//
    }
    
    func updatePost(postBio: String, hr: Int, task: Int, storyPost: Int, city: String, state: String, country: String, category: String, isPostUpdated: Binding<Bool>) async throws {
        guard let docId = post.id else { return }
        isBusy = true
        
        var fields: [AnyHashable: Any] = [:]
        
        if(postBio != post.postBio) {
            fields["postBio"] = postBio
        }
        if(hr != post.hr) {
            fields["hr"] = hr
        }
        if(task != post.task) {
            fields["task"] = task
        }
        if(storyPost != post.storyPost) {
            fields["storyPost"] = storyPost
        }
        if(category != post.category) {
            fields["category"] = category
        }
        if(city != post.city) {
            fields["city"] = city
        }
        if(state != post.state) {
            fields["state"] = state
        }
        if(country != post.country) {
            fields["country"] = country
        }
        if let image = uiImage {
            if let imageUrl = try? await ImageUploader.uploadImage(image: image, type: .post) {
                fields["imageUrl"] = imageUrl
            }
            
        }
        guard !fields.isEmpty else {
            print("DEBUG: Nothing to update.")
            isBusy = false
            return
        }
        
        do {
            let doc = COLLECTION_POSTS.document(docId)
            try await doc.updateData(fields)
            let updatedPost = try await doc.getDocument().data(as: Post.self)
            post = updatedPost
            isPostUpdated.wrappedValue.toggle()
            isBusy = false
        }catch {
            print("DEBUG: ", error.localizedDescription)
            isBusy = false
            errorMsg = error.localizedDescription
        }
    }
    
    func deletePost(isPostUpdated: Binding<Bool>) async throws {
        guard let docId = post.id else { return }
        isBusy = true
        do {
            let doc = COLLECTION_POSTS.document(docId)
            try await doc.delete()
            isPostUpdated.wrappedValue.toggle()
            isBusy = false
        }catch {
            print("DEBUG: ", error.localizedDescription)
            isBusy = false
            errorMsg = error.localizedDescription
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


/*
 
 import SwiftUI
 import PhotosUI
 import FirebaseFirestoreSwift
 import Firebase

 @MainActor
 class EditProfileViewModel: ObservableObject {
     @Published var user: User
     @Published var uploadComplete = false
     @Published var selectedImage: PhotosPickerItem? {
         didSet { Task { await loadImage(fromItem: selectedImage) } }
     }
     @Published var profileImage: Image?
     private var uiImage: UIImage?
     
     var fullname = ""
     var bio = ""
                 
     init(user: User) {
         self.user = user
         
         if let bio = user.bio {
             self.bio = bio
         }
         
         if let fullname = user.fullname {
             self.fullname = fullname
         }
     }
     
     @MainActor
     func loadImage(fromItem item: PhotosPickerItem?) async {
         guard let item = item else { return }
         
         guard let data = try? await item.loadTransferable(type: Data.self) else { return }
         guard let uiImage = UIImage(data: data) else { return }
         self.uiImage = uiImage
         self.profileImage = Image(uiImage: uiImage)

     }
     
     func updateProfileImage(_ uiImage: UIImage) async throws {
         let imageUrl = try? await ImageUploader.uploadImage(image: uiImage, type: .profile)
         self.user.profileImageUrl = imageUrl
     }
     
     func updateUserData() async throws {
         var data: [String: String] = [:]

         if let uiImage = uiImage {
             try? await updateProfileImage(uiImage)
             data["profileImageUrl"] = user.profileImageUrl
         }
         
         
         if !fullname.isEmpty, user.fullname ?? "" != fullname {
             user.fullname = fullname
             data["fullname"] = fullname
         }
         
         if !bio.isEmpty, user.bio ?? "" != bio {
             user.bio = bio
             data["bio"] = bio
         }
         
         try await COLLECTION_USERS.document(user.id).updateData(data)
     }
 }
 
 
 
 
 
 
 
 
 
 
 class ProfileViewModel: ObservableObject {
     @Published var user: User
     
     init(user: User) {
         self.user = user
         
     }
     
     
     
    
 }*/
