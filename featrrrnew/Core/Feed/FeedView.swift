//
//  FeedView.swift
//  featrrrnew
//
//  Created by Buddie Booking on 6/27/23.
//

import SwiftUI

struct FeedView: View {
    @StateObject var viewModel = FeedViewModel()
    @State private var isShowingUploadPostView = false
    @State private var isShowFilter = false
    
    @State var ft_category: String = ""
    @State var ft_city: String = ""
    @State var ft_state: String = ""
    @State var ft_country: String = ""
    
    var body: some View {
        NavigationStack {
            if(isShowFilter) {
                VStack(spacing: 8) {
                    TextField("Category", text: $ft_category)
                        .frame(height: 34)
                    TextField("City", text: $ft_city)
                        .frame(height: 34)
                    TextField("State", text: $ft_state)
                        .frame(height: 34)
                    TextField("Country", text: $ft_country)
                        .frame(height: 34)
                    Button("Apply") {

                        viewModel.updateFilter(category: ft_category, city: ft_city, state: ft_state, country: ft_country)
                        isShowFilter.toggle()
                    }
                    .frame(height: 44)
                }
                .font(.callout)
                .padding()
            }
            ScrollView {
                LazyVStack(spacing: 32) {
                    ForEach(viewModel.posts) { post in
                        NavigationLink (value: post.user) {
                            FeedCell(viewModel: FeedCellViewModel(post: post))
                        }
                    }
                }
                .padding(.top)
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.isShowFilter.toggle()
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.purple)
                    }
                }
            
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.isShowingUploadPostView.toggle()
                    }) {
                        Image(systemName: "photo")
                            .foregroundColor(.purple)
                    }
                    /*NavigationLink {
                        
                        UploadPostView(tabIndex: .constant(0))
                        
                    } label: {
                        Image(systemName: "photo")
                            .foregroundColor(.purple)
                    }*/
                }
                
                
            })
            .navigationTitle("Featrrr")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isShowingUploadPostView){
                UploadPostView(tabIndex: .constant(0), isShowingUploadPostView: self.$isShowingUploadPostView)
            }
            .onAppear {
                Task { try await viewModel.fetchAllPosts() }
            }
            .refreshable {
                Task { try await viewModel.fetchAllPosts() }
            }
            .navigationDestination(for: User.self) { user in
                ProfileView(user: user)
            }
            /*.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        UploadPostView(tabIndex: .constant(0))
                    } label: {
                        Image(systemName: "photo")
                            .foregroundColor(.purple)
                    }
                }
            }*/
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        
            FeedView()
        
    }
}
/*import SwiftUI

struct FeedView: View {
    
    @State private var searchText = ""
    @StateObject var viewModel = FeedViewModel()
    let user: User
    //let post: Post
    
    
   
    var body: some View {
        
            ScrollView {
              
                LazyVStack (spacing: 20){
                    ForEach(viewModel.posts) { post in
                        
                        NavigationLink(value: post.user) {
                            FeedCell(post: post, user: user)
                        }
                    }
                    .padding(.top)
                }
                .padding(.top, 8)
                .searchable(text: $searchText, prompt: "Find Creators")
                
            }
            .navigationTitle("Featrrr")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: User.self, destination: { user in
                ProfileView(user: user, viewModel: PostListViewModel(user: user))})
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        UploadPostView(tabIndex: .constant(0))
                    } label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(.purple)
                    }
                }
            }
        
        
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(user: User.MOCK_USERS[0])
    }
}*/

//.navigationDestination(for: User.self) { user in
//ProfileView(user: user)
//}
