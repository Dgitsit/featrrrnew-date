//
//  EditPostView.swift
//  featrrrnew
//
//  Created by admin on 8/3/23.
//

import SwiftUI
import Kingfisher

struct EditPostView: View {
    @State private var hr = ""
    @State private var task = ""
    @State private var storyPost = ""
    @State private var city = ""
    @State private var state = ""
    @State private var country = ""
    @State private var category = ""
    @State private var postBio = ""
    
    @State private var imagePickerPresented = false
    @StateObject var viewModel: EditPostViewModel
    
    @Binding var isPostUpdated: Bool
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView{
            VStack {
                /* if viewModel.user.isCurrentUser {
                 Button(action: { showEditProfile.toggle() }, label: {
                     Text("Edit Profile")*/
                VStack {
                    if let image = viewModel.imageUrl {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 370, height: 350)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } else {
                        KFImage(URL(string: viewModel.post.imageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 370, height: 350)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .frame(width: 370, height: 350)
                .onTapGesture {
                    self.imagePickerPresented.toggle()
                }
                
                HStack{
                    VStack{
                        TextField("Category", text: $category, axis: .vertical)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .frame(width: 350)
                        
                        TextField("Bio", text: $postBio, axis: .vertical)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .frame(width: 350)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack {
                    VStack {
                        TextField("City", text: $city, axis: .vertical)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .frame(width: 300)
                        
                        TextField("State", text: $state, axis: .vertical)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .frame(width: 300)
                        
                        
                        TextField("Country", text: $country, axis: .vertical)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .frame(width: 300)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack {
                    VStack {
                        TextField("$Hourly rate", text: $hr, axis: .vertical)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .frame(width: 170)
                        
                        TextField("$Task rate", text: $task, axis: .vertical)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .frame(width: 170)
                        
                        TextField("$24hr story post", text: $storyPost, axis: .vertical)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .frame(width: 170)
                        
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                
                Button("Delete Post") {
                    Task {
                        try await viewModel.deletePost(isPostUpdated: _isPostUpdated)
                        dismiss()
                    }
                }
                .foregroundColor(Color.red)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .padding(.all, 32)
            }
            .padding(.top)
            .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
            .onDisappear {
                viewModel.selectedImage = nil
            }
            .onAppear {
                updateData()
            }
        }
        .navigationTitle("Update Post")
        .toolbar {
            Button("Update") {
                Task {
                    try await viewModel.updatePost(postBio:postBio, hr: Int(hr) ?? 0, task: Int(task) ?? 0, storyPost: Int(storyPost) ?? 0, city: city, state: state, country: country, category: category, isPostUpdated: _isPostUpdated)
                    dismiss()
                }
            }
            .disabled(postBio.isEmpty || hr.isEmpty || task.isEmpty || storyPost.isEmpty || city.isEmpty || state.isEmpty || country.isEmpty || category.isEmpty)
        }
    }
    
    func updateData() {
        postBio = viewModel.post.postBio
        hr = "\(viewModel.post.hr)"
        task = "\(viewModel.post.task)"
        storyPost = "\(viewModel.post.storyPost)"
        category = viewModel.post.category
        city = viewModel.post.city
        state = viewModel.post.state
        country = viewModel.post.country
        viewModel.selectedImage = nil
        viewModel.imageUrl = nil
    }
}

struct EditPostView_Previews: PreviewProvider {
    static var previews: some View {
        EditPostView(viewModel: EditPostViewModel(post: dev.posts[3]), isPostUpdated: .constant(false))
    }
}
