//
//  +View.swift
//  Tailored
//
//  Created by Yunior Sanchez on 3/10/23.
//
//the purpose of the below is to be use in order to be bale to log in with Google
import SwiftUI

final class ApplicationUtility {
    static var getRootViewController: UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        return root
    }
}
