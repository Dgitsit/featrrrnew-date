//
//  EnterCardInfoView.swift
//  featrrrnew
//
//  Created by Buddie Booking on 7/8/23.
//

import SwiftUI

struct EnterCardInfoView: View {
    
    @State private var cardNumber = ""
    
    @State private var expNumber = ""
    
    @State private var cvvNumber = ""
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            TextField("Enter 16 digit card number", text: $cardNumber)
                .autocapitalization(.none)
                .modifier(FeatrTextFieldModifier())
            
            HStack{
                TextField("09/28", text: $expNumber)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                TextField("CVV", text: $cvvNumber)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
            .padding()
            
            Spacer()
            
            NavigationLink {
                CompletedHireView()
            } label: {
                Text("Hire")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 360, height: 44)
                    .background(Color(.systemGreen))
                    .cornerRadius(8)
            }
            .padding(.vertical)
        }
    }
}

struct EnterCardInfoView_Previews: PreviewProvider {
    static var previews: some View {
        EnterCardInfoView()
    }
}
