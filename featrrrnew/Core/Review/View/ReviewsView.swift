//
//  ReviewsView.swift
//  featrrrnew
//
//  Created by Buddie Booking on 7/26/23.
//

import SwiftUI

struct ReviewsView: View {
    @State private var reviewText = ""
    @StateObject var viewModel: ReviewViewModel
    
    init(post: Post) {
        self._viewModel = StateObject(wrappedValue: ReviewViewModel(post: post))
    }
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
                    ForEach(viewModel.reviews) { review in
                        CommentCell(review: review)
                    }
                }
            }.padding(.top)
            
            CustomInputView(inputText: $reviewText, placeholder: "Review...", action: uploadReview)
        }
        .navigationTitle("Comments")
        .toolbar(.hidden, for: .tabBar)
    }
    
    func uploadReview() {
        Task {
            await viewModel.uploadReview(reviewText: reviewText)
            reviewText = ""
        }
    }
}
