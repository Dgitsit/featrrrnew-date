//
//  InboxViewModel.swift
//  featrrrnew
//
//  Created by Buddie Booking on 8/10/23.
//

import Foundation
import Combine
import Firebase

class InboxViewModel: ObservableObject {
    @Published var currentUser: User?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        MessageUserService.shared.$currentUser.sink { [weak self]  user in
            self?.currentUser = user
        }.store(in: &cancellables)
    }
}
