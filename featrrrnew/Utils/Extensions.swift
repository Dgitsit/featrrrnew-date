//
//  Extensions.swift
//  featrrrnew
//
//  Created by Buddie Booking on 7/25/23.
//


import UIKit
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
