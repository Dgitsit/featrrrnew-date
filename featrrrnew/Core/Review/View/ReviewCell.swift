//
//  ReviewCell.swift
//  featrrrnew
//
//  Created by Buddie Booking on 7/26/23.
//

import SwiftUI
import Kingfisher

struct CommentCell: View {
    let review: Review
    
    var body: some View {
        HStack {
            KFImage(URL(string: review.profileImageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
            
            Text(review.username).font(.system(size: 14, weight: .semibold)) +
                Text(" \(review.reviewText)").font(.system(size: 14))
            
            Spacer()
            
            Text(" \(review.timestampString ?? "")")
                .foregroundColor(.gray)
                .font(.system(size: 12))
        }.padding(.horizontal)
    }
}
