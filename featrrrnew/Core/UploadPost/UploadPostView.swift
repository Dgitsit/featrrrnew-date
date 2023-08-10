//
//  UploadPostView.swift
//  featrrrnew
//
//  Created by Buddie Booking on 7/10/23.
//

import SwiftUI
import PhotosUI

struct UploadPostView: View {
    
    
    @State private var hr = ""
    @State private var task = ""
    @State private var storyPost = ""
    @State private var city = ""
    @State private var state = ""
    @State private var country = ""
    @State private var category = ""
    @State private var postBio = ""
    
    @State private var imagePickerPresented = false
    @StateObject var viewModel = UploadPostViewModel()
    
    @Binding var tabIndex: Int
    @Binding var isShowingUploadPostView: Bool
    
    var body: some View {
        ScrollView{
            VStack {
                HStack {
                    Button {
                        clearPostData()
                        isShowingUploadPostView.toggle()
                        //imagePickerPresented = false
                        //tabIndex = 0
                    } label: {
                        Text ("Cancel")
                    }
                    
                    Spacer()
                    
                    Text("Become a Featrrr")
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button {
                        Task {
                            try await viewModel.uploadPost(postBio: postBio, hr: Int(hr) ?? 0, task: Int(task) ?? 0, storyPost: Int(storyPost) ?? 0, city: city, state: state, country: country, category: category)
                            
                            clearPostData()
                            isShowingUploadPostView.toggle()
                            //imagePickerPresented = false
                            //tabIndex = 0
                        }
                    } label: {
                        Text ("Upload")
                    }
                    .disabled(postBio.isEmpty || hr.isEmpty || task.isEmpty || storyPost.isEmpty || city.isEmpty || state.isEmpty || country.isEmpty || category.isEmpty)
                }
                .padding(.horizontal)
                
                VStack {
                    if let image = viewModel.imageUrl {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 370, height: 350)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .allowsHitTesting(false)
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
                }
                
                Spacer()
            }
            .padding(.top)
            .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
            .onAppear {
                self.imagePickerPresented.toggle()
            }
            .onDisappear {
                viewModel.selectedImage = nil
            }
        }
    }
    
    func clearPostData() {
        postBio = ""
        hr = ""
        task = ""
        storyPost = ""
        category = ""
        city = ""
        state = ""
        country = ""
        viewModel.selectedImage = nil
        viewModel.imageUrl = nil
        tabIndex = 0
        
    }
}

struct UploadPostView_Previews: PreviewProvider {
    static var previews: some View {
        UploadPostView(tabIndex: .constant(0), isShowingUploadPostView: .constant(true))
    }
}
