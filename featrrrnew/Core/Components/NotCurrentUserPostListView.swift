//
//  NotCurrentUserPostListView.swift
//  featrrrnew
//
//  Created by Buddie Booking on 8/8/23.
//

import SwiftUI
import Kingfisher

struct NotCurrentUserPostListView: View {
    
    //@State var isPostUpdated: Bool = false
    //@Binding var selectedUser: User?
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
            .navigationDestination(for: Post.self, destination: { post in
                PaymentSheetView( post: post, user: viewModel.user)})
            }
        
        
        
        
        
    }
}

struct NotCurrentUserPostListView_Previews: PreviewProvider {
    static var previews: some View {
        NotCurrentUserPostListView(user: dev.user)
    }
}
