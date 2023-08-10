//
//  CreateUserNameView.swift
//  featrrrnew
//
//  Created by Buddie Booking on 6/29/23.
//

import SwiftUI

struct CreateUsernameView: View {
    @EnvironmentObject var viewModel: RegistrationViewModel
    @State private var showCreatePasswordView = false

    var body: some View {
        VStack(spacing: 12) {
            Text("Create username")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("Make a username for your new account. You can always change it later.")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            ZStack(alignment: .trailing) {
                TextField("Username", text: $viewModel.username)
                    .modifier(TextFieldModifier())
                    .padding(.top)
                    .autocapitalization(.none)

                if viewModel.isLoading {
                    ProgressView()
                        .padding(.trailing, 40)
                        .padding(.top, 14)
                }
            }
            
            Button {
                Task {
                    try await viewModel.validateUsername()
                }
            } label: {
                Text("Next")
                    .modifier(FeatchrButtonModifier())
            }
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)

            Spacer()
        }
        .onReceive(viewModel.$usernameIsValid, perform: { usernameIsValid in
            if usernameIsValid {
                self.showCreatePasswordView.toggle()
            }
        })
        .navigationDestination(isPresented: $showCreatePasswordView, destination: {
            CreatePasswordView()
        })
        .onAppear {
            showCreatePasswordView = false
            viewModel.usernameIsValid = false
        }
    }
}

// MARK: - AuthenticationFormProtocol

extension CreateUsernameView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !viewModel.username.isEmpty
    }
}

struct CreateUsernameView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUsernameView()
            .environmentObject(RegistrationViewModel())
    }
}
/*struct CreateUserNameView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    
    var body: some View {
        VStack {
            Text("Create username")
                .font(.title)
                .fontWeight(.bold)
            
            Text("You'll use this username to sign into your account")
                .foregroundColor(.gray)
            
            TextField("Username", text: $viewModel.username)
                .autocapitalization(.none)
                .modifier(FeatrTextFieldModifier())
            
            NavigationLink {
                CreatePasswordView()
            } label: {
                Text("Next")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 360, height: 44)
                    .background(Color(.systemPurple))
                    .cornerRadius(8)
            }
            .padding(.vertical)
            
            Spacer()
        }
    }
}

struct CreateUserNameView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUserNameView()
    }
}*/
