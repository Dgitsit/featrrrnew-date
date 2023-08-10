//
//  CreatePasswordView.swift
//  featrrrnew
//
//  Created by Buddie Booking on 6/29/23.
//

import SwiftUI

struct CreatePasswordView: View {
    @EnvironmentObject var viewModel: RegistrationViewModel

    var body: some View {
        VStack(spacing: 12) {
            Text("Create a password")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("Your password must be at least 6 characters in length.")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            SecureField("Password", text: $viewModel.password)
                .modifier(TextFieldModifier())
                .padding(.top)
            
            NavigationLink {
                CompleteSignUpView()
            } label: {
                Text("Next")
                    .modifier(FeatchrButtonModifier())
            }
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            
            Spacer()
        }
    }
}

// MARK: - AuthenticationFormProtocol

extension CreatePasswordView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !viewModel.password.isEmpty && viewModel.password.count > 5
    }
}

struct CreatePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePasswordView()
            .environmentObject(RegistrationViewModel())

    }
}

/*struct CreatePasswordView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    
    var body: some View {
        VStack {
            Text("Create password")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Your password must be at least 6 characters")
                .foregroundColor(.gray)
            
            TextField("Password", text: $viewModel.password)
                .autocapitalization(.none)
                .modifier(FeatrTextFieldModifier())
            
            NavigationLink {
                CompleteSignUpVIew()
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

struct CreatePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePasswordView()
    }
}*/
