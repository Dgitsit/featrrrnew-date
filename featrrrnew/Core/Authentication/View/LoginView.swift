//
//  LoginView.swift
//  featrrrnew
//
//  Created by Buddie Booking on 6/29/23.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isGuest: Bool = false
    @StateObject var viewModel = LoginViewModel()
    @EnvironmentObject var registrationViewModel: RegistrationViewModel
    
    func continueAsGuest(){
        isGuest = true
    }
    
    var body: some View {
        NavigationStack{
            VStack {
                Spacer()
                
                Image("featrlogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 500, height: 200)
                
                VStack(spacing: 8) {
                    TextField("Enter your email", text: $email)
                        .autocapitalization(.none)
                        .modifier(FeatrTextFieldModifier())
                        
                    
                    SecureField("Password", text: $password)
                        .modifier(FeatrTextFieldModifier())
                }
                
                HStack {
                    Spacer()
                    
                    NavigationLink(
                        destination: ResetPasswordView(email: $email),
                        label: {
                            Text("Forgot Password?")
                                .font(.system(size: 13, weight: .semibold))
                                .padding(.top)
                                .padding(.trailing, 28)
                        })
                }
                
                
                Button(action: {
                    Task { try await viewModel.login(withEmail: email, password: password) }
                }, label: {
                    Text("Log In")
                        
                })
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                
                Button {
                    
                } label: {
                    Text("Continue as guest")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.purple)
                        .cornerRadius(8)
                }
                .padding(.top)
                
                VStack(spacing: 24) {
                    HStack {
                        Rectangle()
                            .frame(width:( UIScreen.main.bounds.width / 2) - 40, height: 0.5)
                            .foregroundColor(Color(.separator))
                        
                        Text("OR")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.gray))
                        
                        Rectangle()
                            .frame(width:( UIScreen.main.bounds.width / 2) - 40, height: 0.5)
                            .foregroundColor(Color(.separator))
                    }
                    
                    HStack {
                        Image("featrlogo")
                            .resizable()
                            .frame(width: 20, height: 20)
                        
                        Text("Continue with Facebook")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.systemBlue))
                    }
                }
                .padding(.top, 4)
                
                Spacer()
                
                Divider()
                
                NavigationLink {
                    AddEmailView()
                        .environmentObject(registrationViewModel)
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                            .font(.system(size: 14))
                        
                        Text("Sign Up")
                            .font(.system(size: 14, weight: .semibold))
                    }
                }
                .padding(.vertical, 16)
            }
        }
        
    }
}

// MARK: - AuthenticationFormProtocol

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(RegistrationViewModel())
    }
}
/*import SwiftUI


struct LoginView: View {
    
    
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()
                
                Image("featrlogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 500, height: 200)
                
                VStack {
                    TextField("Email", text: $viewModel.email)
                        .autocapitalization(.none)
                        .modifier(FeatrTextFieldModifier())
                    
                    SecureField("Password", text: $viewModel.password)
                        .autocapitalization(.none)
                        .modifier(FeatrTextFieldModifier())
                }
                
                Button {
                    
                } label: {
                    Text("Forgot password")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .padding(.trailing, 28)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                Button {
                    Task{ try await viewModel.signIn()}
                } label: {
                    Text("Login")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 44)
                        .background(Color(.systemPurple))
                        .cornerRadius(8)
                }
                
                Button {
                    
                } label: {
                    Text("Continue as guest")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.purple)
                        .cornerRadius(8)
                }
                .padding(.top)
                
                Spacer()
            }
            
            NavigationLink {
                AddEmailView()
                    
            } label: {
                HStack (spacing: 3) {
                    Text("Don't have an account?")
                    
                    Text("Sign up")
                        .fontWeight(.semibold)
                }
            }
            .padding(.vertical, 16)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}*/
