//
//  PaymentSheetViewModel.swift
//  featrrrnew
//
//  Created by Buddie Booking on 7/27/23.
//

import Foundation

class PaymentSheetViewModel: ObservableObject {
   //@Published var post = [Post]()
   // @Published var post: Post
    
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
    
}
