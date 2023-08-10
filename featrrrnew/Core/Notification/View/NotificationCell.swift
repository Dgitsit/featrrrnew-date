//
//  NotificationCell.swift
//  featrrrnew
//
//  Created by Buddie Booking on 7/26/23.
//

import SwiftUI
import Kingfisher

struct NotificationCell: View {
    @ObservedObject var viewModel: NotificationCellViewModel
    @Binding var notification: Notification
    
   
    
    init(notification: Binding<Notification>) {
        self.viewModel = NotificationCellViewModel(notification: notification.wrappedValue)
        self._notification = notification
    }
    
    var body: some View {
        HStack {
            if let user = notification.user {
                NavigationLink(destination: ProfileView(user: user)) {
                    CircularProfileImageView(user: user)
                    
                    HStack {
                        Text(user.username)
                            .font(.system(size: 14, weight: .semibold)) +
                        
                        Text(notification.type.notificationMessage)
                            .font(.system(size: 14)) +
                        
                        Text(" \(viewModel.timestampString)")
                            .foregroundColor(.gray).font(.system(size: 12))
                    }
                    .multilineTextAlignment(.leading)
                }
            }
            
            Spacer()
            
        }
    
    }
}
