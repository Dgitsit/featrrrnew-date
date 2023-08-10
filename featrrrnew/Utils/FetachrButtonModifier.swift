//
//  FetachrButtonModifier.swift
//  featrrrnew
//
//  Created by Buddie Booking on 7/25/23.
//

import Foundation

import SwiftUI

struct FeatchrButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(width: 360, height: 44)
            .background(Color(.systemPurple))
            .cornerRadius(8)
            .padding()
    }
}
