//
//  PostListView.swift
//  featrrrnew
//
//  Created by Buddie Booking on 6/29/23.
//

import SwiftUI
import Kingfisher

struct PostListView: View {
    
    @State var isPostUpdated: Bool = false
    
    @StateObject var viewModel: PostListViewModel
    
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: PostListViewModel(user: user))
    }
    
    var body: some View {
        LazyVStack(spacing: 24) {
            ForEach(viewModel.posts) { post in
                NavigationLink(value: post) {
                    KFImage(URL(string: post.imageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 370, height: 350)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
//                .navigationTitle("Cancel")
            }
            .navigationDestination(for: Post.self) { post in
//                FeedCell(viewModel: FeedCellViewModel(post: post))
               
                EditPostView(viewModel: EditPostViewModel(post: post), isPostUpdated: $isPostUpdated)
            }
        }
        .onChange(of: isPostUpdated, perform: { _ in
            viewModel.fetchPosts()
        })
        
        /*if viewModel.user.isCurrentUser {
         Button(action: { showEditPost.toggle() }, label: {
             Text("Edit Post")
                 .font(.system(size: 14, weight: .semibold))
                 .frame(width: 360, height: 32)
                 .foregroundColor(.purple)
                 .overlay(
                     RoundedRectangle(cornerRadius: 6)
                         .stroke(Color.gray, lineWidth: 1)
                 )
         }).fullScreenCover(isPresented: $showEditPost) {
             PostListViewModel(user: User)
         }
     } else {
         VStack {
         EmptyView()
         }
         }*/
        
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView(user: dev.user)
    }
}
/*import SwiftUI
import Kingfisher

struct PostListView: View {
    
    //let user: User
    @StateObject var viewModel: PostListViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: PostListViewModel(user: user))
    }
    //var posts: [Post]
    
    var body: some View {
        
        LazyVStack(spacing: 24) {
            ForEach(viewModel.posts) { post in
               // NavigationLink(value: post) {
                    VStack {
                        KFImage(URL(string: post.postImageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 370, height: 350)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    /*Image(post.postImageUrl)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 370, height: 350)
                        .clipShape(RoundedRectangle(cornerRadius: 10))*/
                    
                        VStack {
                            HStack {
                                Text("$\(post.hr)/hr")
                                    .fontDesign(.serif)
                                    .fontWeight(.bold)
                                
                                
                                Spacer()
                                
                                Text("Rating")
                                
                            }
                            .padding(.horizontal, 15)
                            
                            HStack {
                                Text(post.category)
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            HStack {
                                VStack {
                                    Text("\(post.city), \(post.state) \(post.country)")
                                }
                                .padding(.horizontal)
                                Spacer()
                                
                            }
                            
                            
                            
                            HStack {
                                Text("task: $\(post.task) / story post $\(post.storyPost)")
                                
                                Spacer()
                            }
                            .padding(.horizontal, 15)
                            
                            Text(post.postBio)
                                .padding()
                            Divider()
                        }
                        
                    }
                    /*.navigationDestination(for: Post.self, destination: { post in
                        PaymentSheetView( post: post)})*/
                }
                
            //}
            /*.navigationDestination(for: Post.self, destination: { post in
                PaymentSheetView( post: post)})*/
        }
        
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView(user: User.MOCK_USERS[0]/*, posts: Post.MOCK_POST*/)
    }
}*/
