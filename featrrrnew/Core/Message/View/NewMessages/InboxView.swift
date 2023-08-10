//
//  InboxView.swift
//  featrrrnew
//
//  Created by Buddie Booking on 8/9/23.
//

import SwiftUI

struct InboxView: View {
    
    let user: User
    @StateObject var viewModel = InboxViewModel()
    /*private var user: User? {
        return viewModel.currentUser
    }*/
    
    var body: some View {
        
        NavigationStack{
            ScrollView {
                List {
                    ForEach(0 ... 10, id: \.self) { message in
                        InboxRowView(user: user)
                    }
                }
                .listStyle(PlainListStyle())
                .frame(height: UIScreen.main.bounds.height - 120)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        CircularProfileImageView(user: user)
                        
                        Text("Messages")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                }
            }
        }
    }
}

struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        InboxView(user: dev.user)
    }
}
