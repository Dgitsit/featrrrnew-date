//
//  NewMessageView.swift
//  featrrrnew
//
//  Created by Buddie Booking on 7/26/23.
//

import SwiftUI

struct NewMessageView: View {
    @State var searchText = ""
    @Binding var show: Bool
    @Binding var startChat: Bool
    @Binding var user: User?
    
    @ObservedObject var viewModel = SearchViewModel(config: .newMessage)
    
    var body: some View {
        ScrollView {
            //SearchBar(text: $searchText, isEditing: .constant(false))
                //.padding()

            LazyVStack(alignment: .leading) {
                ForEach(searchText.isEmpty ? viewModel.users : viewModel.filteredUsers(searchText)) { user in
                    HStack { Spacer() }
                    
                    Button(action: {
                        self.show.toggle()
                        self.startChat.toggle()
                        self.user = user
                    }, label: {
                        UserCell(user: user)
                    })
                }
            }.padding(.leading)
        }
    }
}
