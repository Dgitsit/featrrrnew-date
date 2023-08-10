//
//  SettingsView.swift
//  featrrrnew
//
//  Created by Buddie Booking on 7/11/23.
//

import SwiftUI

enum SettingsItemModel: Int, Identifiable, Hashable, CaseIterable {
    case settings
    case saved
    case logout
    
    var title: String {
        switch self {
        case .settings:
            return "Settings"
        case .saved:
            return "Saved"
        case .logout:
            return "Logout"
        }
    }
    
    var imageName: String {
        switch self {
        case .settings:
            return "gear"
        case .saved:
            return "bookmark"
        case .logout:
            return "arrow.left.square"
        }
    }
    
    var id: Int { return self.rawValue }
}

struct SettingsView: View {
    @Binding var selectedOption: SettingsItemModel?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Capsule()
                .frame(width: 32, height: 4)
                .foregroundColor(.gray)
                .padding()
                
            List {
                ForEach(SettingsItemModel.allCases) { model in
                    SettingsRowView(model: model)
                        .onTapGesture {
                            selectedOption = model
                            dismiss()
                        }
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}

struct SettingsRowView: View {
    let model: SettingsItemModel
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: model.imageName)
                .imageScale(.medium)
            
            Text(model.title)
                .font(.subheadline)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(selectedOption: .constant(nil))
    }
}

/*import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                NavigationLink(destination: {
                    PersonalInfoView()
                }) {
                    HStack {
                        Text("Personal Info")
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                    }
                    .padding(.horizontal, 25)
                    .foregroundColor(.black)
                }
                
                NavigationLink(destination: {
                    TransactionAndCardView()
                }) {
                    HStack {
                        Text("Transactions / Card Info")
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                    }
                    .padding(25)
                    .foregroundColor(.black)
                
                }
                Spacer()
                Button(action:{
                    AuthService.shared.signout()
                }) {
                    Text("Logout")
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}*/
