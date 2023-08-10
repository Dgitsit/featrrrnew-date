//
//  CalendarView.swift
//  featrrrnew
//
//  Created by Buddie Booking on 6/29/23.
//

import SwiftUI

struct CalendarView: UIViewRepresentable{
    
    let interval: DateInterval
    
    func makeUIView(context: Context) -> UICalendarView {
        let view = UICalendarView()
        view.calendar = Calendar(identifier: .gregorian)
        view.availableDateRange = interval
        return view
    }
    
    func updateUIView(_ uiView: UICalendarView, context: Context) {
        
    }
    
   
    
    
  
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
       
            CalendarView(interval: DateInterval(start: .now, end: .distantFuture))
            
        
    }
}
