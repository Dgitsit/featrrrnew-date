//
//  SwiftUIView.swift
//  featrrrnew
//
//  Created by Buddie Booking on 7/13/23.
//

import SwiftUI

struct TransactionAndCardView: View {
    @State private var sixteendigit = ""
    
    @State private var monthYear = ""
    
    @State private var cvv = ""
    
    
    @State private var zipcode = ""
    
    var body: some View {
        
        ScrollView {
            
            VStack{
                HStack{
                    Text("Balance: $1,238")
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding()
                
                HStack {
                    Image(systemName: "creditcard")
                    
                    Text("...1234")
                    
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("edit")
                    }
                    
                }
                .padding()
                
                HStack {
                    
                    VStack{
                       
                        
                        HStack{
                            TextField("0000 0000 0000 0000", text: $sixteendigit)
                                .keyboardType(.numberPad)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                                .frame(width: 250)
                            
                            Spacer()
                        }
                        
                        VStack {
                            
                            HStack{
                                
                                TextField("MM/YY", text: $monthYear)
                                    .keyboardType(.numberPad)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                    .frame(width: 100)
                                
                                TextField("CVV", text: $cvv)
                                    .keyboardType(.numberPad)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                    .frame(width: 100)
                                
                                TextField("Zip", text: $zipcode)
                                    .keyboardType(.numberPad)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                    .frame(width: 100)
                                
                                Spacer()
                            }
                            
                            
                            Button {
                                
                            } label: {
                                Text("Add Card")
                            }
                            .padding(.top)
                        }
                        
                    }
                    .padding()
                    
                    
                }
                
                
                Divider()
                    .padding(.horizontal)
                
                
                    Text("Transaction History")
                    .padding(.bottom, 20)
                
                HStack {
                    VStack{
                        Text("July 13, 2023")
                            .fontWeight(.thin)
                            .font(.system(size: 12))
                        
                        Text("@toWhomWasPaid")
                        
                    }
                    
                    Spacer()
                    
                    Text("- $90")
                    
                }
                .padding()
                
                
                
                HStack {
                    VStack{
                        Text("July 13, 2023")
                            .fontWeight(.thin)
                            .font(.system(size: 12))
                        
                        Text("@fromWhoPaid")
                        
                    }
                    
                    Spacer()
                    
                    Text("+ $215")
                    
                }
                .padding()
                
                
            }
        }
    }
}

struct TransactionAndCardViewPreviews: PreviewProvider {
    static var previews: some View {
        TransactionAndCardView()
    }
}
