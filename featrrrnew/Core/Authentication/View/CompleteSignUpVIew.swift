//
//  CompleteSignUpVIew.swift
//  featrrrnew
//
//  Created by Buddie Booking on 6/29/23.
//

import SwiftUI

struct CompleteSignUpView: View {
    @EnvironmentObject var viewModel: RegistrationViewModel

    var body: some View {
        VStack(spacing: 12) {
            Spacer()

            Text("Welcome to Featchr, \(viewModel.username)")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
                .multilineTextAlignment(.center)
            
            Text("Click below to complete registration and start using Instagram.")
                .font(.footnote)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            Button {
                Task { try await viewModel.createUser() }
            } label: {
                Text("Complete Sign Up")
                    .modifier(FeatchrButtonModifier())
            }
            
            Spacer()
        }
    }
}

struct CompleteSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        CompleteSignUpView()
            .environmentObject(RegistrationViewModel())
    }
}

/*struct CompleteSignUpVIew: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Welcome to Featrrr \(viewModel.username)")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Click below to complete registration and begin using Featrrr")
                .multilineTextAlignment(.center)
                .padding(.top,3)
            
          
            
            Button {
                Task { try await  viewModel.createUser() }
            } label: {
                Text("Complete Sign Up")
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

struct CompleteSignUpVIew_Previews: PreviewProvider {
    static var previews: some View {
        CompleteSignUpVIew()
    }
}
*/
