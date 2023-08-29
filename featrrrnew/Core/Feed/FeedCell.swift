//
//  FeedCell.swift
//  featrrrnew
//
//  Created by Buddie Booking on 6/27/23.
//


import SwiftUI
import Kingfisher

struct FeedCell: View {
    @ObservedObject var viewModel: FeedCellViewModel
    
    @State private var bottomSheet = false
    
    init(viewModel: FeedCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            
            HStack {
                if let user = viewModel.post.user {
                    CircularProfileImageView(user: user)
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    
                    NavigationLink(value: user) {
                        VStack {
                            
                            Text("@\(user.username)")
                                .foregroundColor(.white)
                                .padding()
                            
                        }
                        .frame( height: 30)
                        .background(Color.purple)
                        .cornerRadius(8)
                    }
                }
                Spacer()
            }
            .padding(.bottom, 8)
            
            KFImage(URL(string: viewModel.post.imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 370, height: 350)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            
           /* NavigationLink(destination: ReviewsView(post: viewModel.post)) {
                //Image(systemName: "bubble.right")
                HStack {
                    Text("reviews")
                    //.resizable()
                        .scaledToFill()
                    //.frame(width: 20, height: 20)
                        .font(.system(size: 20))
                    //.padding()
                        .foregroundColor(.black)
                    Spacer()
                }
                    
            }*/
            
            
            VStack {
                HStack {
                    Text("$\(viewModel.post.hr)")
                        .fontDesign(.serif)
                        .fontWeight(.bold)
                    
                    
                    Spacer()
                    
                    /*Button (action: {
                        bottomSheet.toggle()
                    }) {
                        ReviewsView(post: viewModel.post)
                    }*/
                    

                        
                    
                }
                
                HStack {
                    Text(viewModel.post.category)
                    Spacer()
                }
                
                
                HStack {
                    VStack {
                    
                        Text("\(viewModel.post.city), \(viewModel.post.state) \(viewModel.post.country)")
                            //.padding(.horizontal)
                    }
                    
                    Spacer()
                    
                }
                
                HStack {
                    Text("task: $\(viewModel.post.task) / story post $\(viewModel.post.storyPost)")
                    
                    Spacer()
                }
                
            }
        }
        .padding(.horizontal)
    }
}

struct FeedCell_Previews: PreviewProvider {
    static var previews: some View {
        
        FeedCell(viewModel: FeedCellViewModel(post: dev.posts[3]))
            .background(Color.cyan)
        
    }
}

/*struct FeedCell: View {
    
    @State private var showBuySheet = false
    
    let post: Post
    let user: User
    /*var posts: [Post] {
        return Post.MOCK_POST.filter({ $0.user?.username == user.username })
    }*/
    var posts: [Post] {
        return Post.MOCK_POST
    }
    
    
    var body: some View {
  
            VStack {
                    VStack {
                        
                        HStack {
                            if let user = post.user {
                                CircularProfileImageView(user: user)
                                /*Image(user.profileImageUrl ?? "")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())*/
                                
                                VStack {
                                    
                                    Text("@\(user.username)")
                                        .foregroundColor(.white)
                                        .padding()
                                    
                                }
                                .frame( height: 30)
                                .background(Color.purple)
                                .cornerRadius(8)
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        VStack {
                            //Image(post.postImageUrl)
                            KFImage(URL(string: post.postImageUrl))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 370, height: 350)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                        }
                        
                            
                        
                        VStack {
                            HStack {
                                Text("$\(post.hr)")
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
                                        .padding(.horizontal)
                                }
                                
                                Spacer()
                                
                            }
                            
                            HStack {
                                Text("task: $\(post.task) / story post $\(post.storyPost)")
                                
                                Spacer()
                            }
                            .padding(.horizontal, 15)
                            
                        
                        }
                
                }
                
            }
            .padding(.bottom)
        
        
        
    }
}

struct FeedCell_Previews: PreviewProvider {
    static var previews: some View {
        
        FeedCell(post: Post.MOCK_POST[0], user: User.MOCK_USERS[0])
        
    }
}
*/
