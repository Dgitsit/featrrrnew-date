//
//  PersonalInfoView.swift
//  featrrrnew
//
//  Created by Buddie Booking on 7/13/23.
//

import SwiftUI

struct PersonalInfoView: View {
    
    @State private var email = ""
    @State private var fullName = ""
    @State private var address = ""
    @State private var city = ""
    @State private var state = ""
    @State private var dob = ""
    @State private var password = ""
    @State private var username = ""
    
    var body: some View {
        ScrollView {
            HStack {
                VStack {
                    
                    VStack{
                        Text("Full Name")
                            .fontWeight(.thin)
                            .font(.system(size: 12))
                        
                        TextField("Jordan Marono", text: $fullName)
                    }
                    .padding()
                    
                    VStack {
                        Text("Username")
                            .fontWeight(.thin)
                            .font(.system(size: 12))
                     
                        TextField("", text: $username)
                    }
                    .padding()
                    
                   
                        VStack{
                                VStack{
                                    Text("Email")
                                        .fontWeight(.thin)
                                        .font(.system(size: 12))
                                    
                                    TextField("JordanM@gmail.com", text: $email)
                                }
                                .padding()
                                
                                VStack {
                                    Text("Address")
                                        .fontWeight(.thin)
                                        .font(.system(size: 12))
                                    TextField("48 Bridge St", text: $address)
                                }
                                .padding()
                                
                                VStack {
                                    Text("City")
                                        .fontWeight(.thin)
                                        .font(.system(size: 12))
                                    TextField("Houston", text: $city)
                                }
                                .padding()
                                
                                VStack {
                                    Text("State")
                                        .fontWeight(.thin)
                                        .font(.system(size: 12))
                                    
                                    TextField("Texas", text: $state)
                                }
                                .padding()
                                
                                VStack {
                                    Text("DOB")
                                        .fontWeight(.thin)
                                        .font(.system(size: 12))
                                    
                                    TextField("08 / 26 / 2004", text: $dob)
                                        .keyboardType(.numberPad)
                                }
                                .padding()
                            
                            VStack {
                                Text("Password")
                                    .fontWeight(.thin)
                                    .font(.system(size: 12))
                                
                                TextField("", text: $password)
                            }
                        }
                    
                    Button {
                        
                    } label: {
                        Text("Edit")
                    }
                }
                
            }
            .padding(.horizontal)
            Spacer()
        }
    }
}

struct PersonalInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalInfoView()
    }
}
