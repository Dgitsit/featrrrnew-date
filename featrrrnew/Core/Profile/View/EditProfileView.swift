//
//  EditProfileView.swift
//  featrrrnew
//
//  Created by Buddie Booking on 7/24/23.
//

import SwiftUI
import Kingfisher
import PhotosUI

struct EditProfileView: View {
    @State private var username = ""

    @StateObject private var viewModel: EditProfileViewModel
    @Binding var user: User
    @Environment(\.dismiss) var dismiss
    
    init(user: Binding<User>) {
        self._user = user
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user.wrappedValue))
        self._username = State(initialValue: _user.wrappedValue.username)
    }
    
    var body: some View {
        VStack {
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                
                Spacer()
                
                Text("Edit Profile")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    Task {
                        try await viewModel.updateUserData()
                        dismiss()
                    }
                } label: {
                    Text("Done")
                        .bold()
                }
            }
            .padding(.horizontal, 8)
            
            VStack(spacing: 8) {
                Divider()
                
                PhotosPicker(selection: $viewModel.selectedImage) {
                        VStack {
                            if let image = viewModel.profileImage {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 370, height: 350)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            } else {
                                RoundedRectangleView(user: viewModel.user)
                            }
                            Text("Edit profile picture")
                                .font(.footnote)
                                .fontWeight(.semibold)
                        }
                    }
                    .padding(.vertical, 8)
                
                Divider()
            }
            .padding(.bottom, 4)
            
            VStack {
                EditProfileRowView(title: "Name", placeholder: "Enter your name..", text: $viewModel.fullname)
                
                EditProfileRowView(title: "Bio", placeholder: "Enter your bio..", text: $viewModel.bio)
            }
            
            Spacer()
        }
        .onReceive(viewModel.$user, perform: { user in
            self.user = user
        })
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EditProfileRowView: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        
        HStack {
            Text(title)
                .padding(.leading, 8)
                .frame(width: 100, alignment: .leading)
                            
            VStack {
                TextField(placeholder, text: $text)
                
                Divider()
            }
        }
        .font(.subheadline)
        .frame(height: 36)
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: .constant(dev.user))
    }
}
/*import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel: EditProfileViewModel
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Button("Cancel") {
                        dismiss()
                    }
                    
                    Spacer()
                    
                    Text("Edit Profile")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button {
                        Task {try await viewModel.updateUserData()}
                        dismiss()
                    } label: {
                        Text("Done")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                }
                .padding(.horizontal)
                
                Divider()
            }
            
            PhotosPicker(selection: $viewModel.selectedImage) {
                VStack {
                    if let image = viewModel.profileImageUrl {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 370, height: 350)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }else {
                        
                        RoundedRectangleView(user: viewModel.user)
                        /*Image(systemName: "person")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 370, height: 350)
                        .clipShape(RoundedRectangle(cornerRadius: 10))*/
                    }
                    
                    Text("Edit profile picture")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    Divider()
                }
            }
            .padding()
            
            VStack {
                EditProfileRowView(title: "Name", placeholder: "Enter your name", text: $viewModel.fullname)
                
                EditProfileRowView(title: "Bio", placeholder: "Enter your bio", text: $viewModel.bio)
            }
            
            Spacer()
        }
    }
}

struct EditProfileRowView: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    var body: some View {
        HStack {
            Text("Title")
                .padding(.leading, 8)
                .frame(width: 100, alignment: .leading)
            
            VStack {
                TextField(placeholder, text: $text)
                
                Divider()
            }
        }
        .font(.subheadline)
        .frame(height: 36)
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: User.MOCK_USERS[0])
    }
}*/
