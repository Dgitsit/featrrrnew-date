//
//  ConversationView.swift
//  featrrrnew
//
//  Created by Buddie Booking on 7/26/23.
//

import SwiftUI

struct ConversationsView: View {
    @State var isShowingNewMessageView = false
    @State var showChat = false
    @State var user: User?
    @StateObject var viewModel = ConversationsViewModel()
    
    var body: some View {
        NavigationStack{
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.recentMessages) { message in
                        NavigationLink {
                            if let user = message.user {
                                ChatView(user: user)
                            }
                        } label: {
                            ConversationCell(message: message)
                        }
                    }
                }.padding()
            }
            .toolbar(.hidden, for: .tabBar)
            .navigationTitle("Messages")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                Button {
                    isShowingNewMessageView.toggle()
                } label: {
                    Image(systemName: "square.and.pencil")
                        .imageScale(.large)
                        .foregroundColor(.purple)
                }
            })
        }
    }
        
}

struct ConversationsView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationsView()
    }
}

/**.toolbar(content: {
 Button {
     isShowingNewMessageView.toggle()
 } label: {
     Image(systemName: "square.and.pencil")
         .imageScale(.large)
         .foregroundColor(.purple)
 }*/
