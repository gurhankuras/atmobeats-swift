//
//  UIApplication+endEditing.swift
//  musicmood
//
//  Created by Gurhan on 12/8/25.
//
import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil, from: nil, for: nil)
    }
}
