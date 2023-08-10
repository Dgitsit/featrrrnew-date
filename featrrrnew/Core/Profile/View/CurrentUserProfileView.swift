//
//  CurrentUserProfileView.swift
//  featrrrnew
//
//  Created by Buddie Booking on 6/29/23.
//

import SwiftUI

struct CurrentUserProfileView: View {
    let user: User
    @StateObject var viewModel: ProfileViewModel
    @State private var showSettingsSheet = false
    @State private var selectedSettingsOption: SettingsItemModel?
    @State private var showDetail = false
    @State private var bottomSheet = false
    @State var bottomSheetContent: SettingsView? = nil
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: ProfileViewModel(user: user))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    ProfileHeaderView(viewModel: viewModel)
                    if viewModel.user.isCurrentUser {
                     
                    PostListView(user: user)
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $showDetail, destination: {
                Text(selectedSettingsOption?.title ?? "")
            })
            .sheet(isPresented: $showSettingsSheet) {
                SettingsView(selectedOption: $selectedSettingsOption)
                    .presentationDetents([.height(CGFloat(SettingsItemModel.allCases.count * 56))])
            }
            
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        selectedSettingsOption = nil
                        showSettingsSheet.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }
                }
            })
            .onChange(of: selectedSettingsOption) { newValue in
                guard let option = newValue else { return }
                
                if option != .logout {
                    self.showDetail.toggle()
                } else {
                    AuthService.shared.signout()
                }
            }
        }
    }
}

struct CurrentUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentUserProfileView(user: dev.user)
    }
}
/*import SwiftUI

struct CurrentUserProfileView: View {
    
    @State private var bottomSheet = false
    @State var bottomSheetContent: SettingsView? = nil
    
    let user: User
    
   
    
    
        
    var body: some View {
            NavigationStack {
                ScrollView {
                   
                        
                    ProfileHeaderView(user: user)
                    
                        Spacer()
                        
                    PostListView(user: user)
                        
                        
                    }
                    .navigationTitle("Profile")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                bottomSheet.toggle()
                            }) {
                                Image(systemName: "line.3.horizontal")
                                    .foregroundColor(.purple)
                        }
                    }
                       
                }
                .sheet(isPresented: $bottomSheet) {
                        SettingsView()
                    }
               
                }
                .ignoresSafeArea()
                
                
            }
    }



struct CurrentUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentUserProfileView(user: dev.user)
    }
}*/
