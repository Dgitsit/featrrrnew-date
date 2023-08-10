//
//  LoginViewModel.swift
//  featrrrnew
//
//  Created by Buddie Booking on 7/23/23.
//

import Foundation

import Foundation

class LoginViewModel: ObservableObject {
    func login(withEmail email: String, password: String) async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
}
/*class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws {
      try await  AuthService.shared.login(withEmail: email, password: password)
    }
}*/
