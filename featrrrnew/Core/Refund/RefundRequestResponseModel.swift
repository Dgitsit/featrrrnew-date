//
//  RefundRequestResponseModel.swift
//  SwiftUIProject
//
//  Created by CodistanVentures on 10/31/23.
//

import Foundation

// MARK: - Welcome
struct RefundRequestDTO: Codable {
    let success: Bool
    let message: String
    let refundRequests: [RefundRequest]?
}

// MARK: - RefundRequest
struct RefundRequest: Codable,Identifiable {
    let id: String
    //let postID, userID, refundID: String
    let status: RefundStatus
    let post: RefundPost

    enum CodingKeys: String, CodingKey {
        case id
        case status, post
    }
}

enum RefundStatus: String,Codable{
    case pending = "pending"
    case completed = "completed"
    case approved = "approved"
}

// MARK: - Post
struct RefundPost: Codable {
    let country, city, postBio: String
    let imageURL: String
    let state, ownerUid, category: String
    //let timestamp: Timestamp
    let paidUsers: [String]
    //let refundRequestedUsers: [JSONAny]
    let hr, storyPost, task: Int

    enum CodingKeys: String, CodingKey {
        case country, city, postBio
        case imageURL = "imageUrl"
        case state, ownerUid, category, paidUsers, hr, storyPost, task
    }
}


