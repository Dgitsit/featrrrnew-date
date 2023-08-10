//
//  PaymentSheetView.swift
//  featrrrnew
//
//  Created by Buddie Booking on 7/6/23.
//

import SwiftUI
import Kingfisher

struct PaymentSheetView: View {
    
        
    //@StateObject var viewModel: PostListViewModel
    
    //@Binding var selectedUser: User?
    
    @State var currentTimeHr = Date()
    @State var endTimeHr = Date()
    
    @State var currentTimeTask = Date()
    
    @State var currentTimeStoryPost = Date()
    
    var post: Post
    
    let user: User
    
    var closedRange = Calendar.current.date(byAdding: .year, value: -1, to: Date())!
    
    @State private var isToggledHr = false
    
    @State private var isToggledTask = false
    
    @State private var isToggledStoryPost = false
    
    @State private var isEditing = false
    
    @State private var showTextField = false
    
    @State private var messageText = ""
    
    @State private var showBottomSheet = false
 
    
    func getTimeDifference(post: Post, start: Date, end: Date, rate: Double, isToggledTask: Bool, isToggledStoryPost: Bool, isToggledHr: Bool) -> Double {
        let calendar = Calendar.current
        let startComponents = calendar.dateComponents([.hour, .minute], from: start)
       
        let endComponents = calendar.dateComponents([.hour, .minute], from: end)
        
        let startHours = Double(startComponents.hour ?? 0)
        let startMinutes = Double(startComponents.minute ?? 0)
        let endHour = Double(endComponents.hour ?? 0)
        let endMinute = Double(endComponents.minute ?? 0)
        let totalHours = endHour - startHours + ((endMinute - startMinutes) / 60)
        var totalCost = totalHours * rate
        
        if !isToggledHr {
            totalCost -= totalCost
        }
       
        if isToggledTask {
            totalCost += Double(post.task)
        }
        
        if isToggledStoryPost {
            totalCost += Double(post.storyPost)
        }
        
        return totalCost
    }
    
    
  
    
    var body: some View {
        ScrollView{
            VStack {
                KFImage(URL(string: post.imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 370, height: 350)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                
                Text(post.category)
                
                
                
                
                VStack{
                    Form {
                        if !isToggledHr {
                            Toggle("Hourly - $\(post.hr)", isOn: $isToggledHr)
                            
                        }
                        else {
                            Section(header: Text("Hourly is usually done together with the hirer, and paid based on time. Choose a day and time  to begin working together.")) {
                                DatePicker("Hourly - $\(post.hr)", selection: $currentTimeHr, in: Date()...)
                                
                                DatePicker("End TIme", selection: $endTimeHr, displayedComponents: .hourAndMinute)
                                
                                
                                Toggle("", isOn: $isToggledHr)
                            }
                        }
                        
                        
                        if !isToggledTask {
                            Toggle("Task - $\(post.task)", isOn: $isToggledTask)
                        }
                        else {
                            Section(header: Text("Task are generally done apart from the hirer, recorded content associated with the talent's category and sent back to the hirer to be featrrred. Choose what day you want this task completed and sent to you.")) {
                                DatePicker("Task - $\(post.task)", selection: $currentTimeTask, displayedComponents: .date)
                                
                                Toggle("", isOn: $isToggledTask)
                            }
                        }
                        
                        
                        if !isToggledStoryPost {
                            Toggle("Story post - $\(post.storyPost)", isOn: $isToggledStoryPost)
                            
                        }
                        else {
                            Section(header: Text("All story post are to last a minimum of 24hrs. Choose a day and time you would like this talent to post you and you can specify on which platform you'd like to be posted (prices usually reflect the best of their  socialmedia).")) {
                                DatePicker("Story post - $\(post.storyPost)", selection: $currentTimeStoryPost, in: Date()...)
                                
                                Toggle("", isOn: $isToggledStoryPost)
                            }
                        }
                    }
                    .frame(height: 200)
                    .cornerRadius(8)
                    
                }
                .padding()
                
                
                Spacer()
                ScrollView {
                    
                    
                    ZStack {
                        if isToggledHr || isToggledTask || isToggledStoryPost {
                            if !showTextField {
                                Button (action: {
                                    showBottomSheet.toggle()
                                })
                                {
                                    let hr = post.hr
                                    let isToggledTask = isToggledTask
                                    let isToggledStoryPost = isToggledStoryPost
                                    let totalCost = max(5, getTimeDifference(post: post, start: currentTimeHr, end: endTimeHr, rate: Double(hr), isToggledTask: isToggledTask, isToggledStoryPost: isToggledStoryPost, isToggledHr: isToggledHr))
                                    let formattedCost = String(format: "%.2f", totalCost)
                                    
                            
                                        Text("Total: $\(formattedCost)")
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                            .frame(width: 360, height: 44)
                                            .background(Color(.systemPurple))
                                            .cornerRadius(8)
                                    
                                }
                                
                            }
                            
                        }
                    }
                    .sheet(isPresented: $showBottomSheet) {
                        
                        ChatView(user: user)
                        
                    }
                }
                
                
                
            }
            
        }
    }
}




struct PaymentSheetView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentSheetView( post: dev.posts[0], user: dev.user)
    }
}
