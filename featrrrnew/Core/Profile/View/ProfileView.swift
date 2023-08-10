//
//  SwiftUIView.swift
//  featrrrnew
//
//  Created by Buddie Booking on 6/27/23.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    @StateObject var viewModel: ProfileViewModel
    
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: ProfileViewModel(user: user))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                ProfileHeaderView(viewModel: viewModel)
                
                NotCurrentUserPostListView(user: user)
            }
            .navigationTitle(user.username)
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationDestination(for: Post.self, destination: { post in
            PaymentSheetView( post: post, user: user)
            
            //PaymentSheetView( viewModel: //PostListViewModel(user: user), post: post)})
        })}
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: dev.user)
    }
}
/*import SwiftUI

struct ProfileView: View {
    let user: User
    //let post: Post
    
   @State private var isShowingPaymentView = false
    
    @StateObject var viewModel : PostListViewModel
    
    
    
    var body: some View {
        
        ScrollView {
            
            ProfileHeaderView(user: user)
            
            Spacer()
            
            LazyVStack {
                /*ForEach(Post.MOCK_POST) { post in
                 /* Button(action:{
                  self.isShowingPaymentView = true
                  }) {
                  PostListView(user: user, posts: posts)
                  }*/
                 /*NavigationLink(destination: PaymentSheetView(post: post, user: user)) {
                  PostListView(user: user, posts: posts)
                  }*/
                 
                 //PostListView(user: user, posts: posts)
                 
                 
                 
                 }*/
                
                ForEach(viewModel.posts) { post in
                    NavigationLink(value: post) {
                        PostListView(user: user)
                    }
                    
                }
                
            }
            .ignoresSafeArea()
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationDestination(for: Post.self, destination: { post in
            PaymentSheetView( viewModel: PostListViewModel(user: user), post: post)})
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User.MOCK_USERS[0], viewModel: PostListViewModel(user: User.MOCK_USERS[0]))
    }
}*/
