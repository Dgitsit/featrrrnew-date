//
//  SwiftUIView.swift
//  featrrrnew
//
//  Created by Buddie Booking on 6/27/23.
//

import SwiftUI

struct MainTabView: View {
    let user: User
    @Binding var selectedIndex: Int
    
    //@State private var selectedIndex = 0
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            //NavigationStack {
                FeedView()
                    .onAppear {
                        selectedIndex = 0
                    }
                    .tabItem{
                        Image(systemName: "house")
                            
                    }
                    .tag(0)
           //.tabItem{
                //Image(systemName: "magnifyingglass")
                    //.tag(0)
                
            //}
                
              RefundView()
                    .onAppear {
                        selectedIndex = 1
                    }
                    .tabItem{
                        Image(systemName: "creditcard")
                    }
                    .tag(1)
                
                CalendarView(interval: DateInterval(start: .now, end: .distantFuture))
                    .onAppear {
                        selectedIndex = 2
                    }
                    .tabItem{
                        Image(systemName: "calendar")
                    }
                    .tag(2)
                
                InboxView()
                    .onAppear {
                        selectedIndex = 3
                    }
                    .tabItem{
                        Image(systemName: "message")
                    }
                    .tag(3)
                
                CurrentUserProfileView(user: user)
                    .onAppear {
                        selectedIndex = 4
                    }
                    .tabItem{
                        Image(systemName: "person")
                    }
                    .tag(4)
            
        }
    }
}

/*struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(user: dev.user)
    }
}*/
