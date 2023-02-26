//
//  ForgotPasswordViewModel.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/16/23.
//

import Foundation
import Combine

protocol ForgotPasswordViewModel {
    func sendPasswordReset()
    var service: ForgotPasswordService { get }
    var email: String { get }
    init(service: ForgotPasswordService)
}

final class ForgotPasswordViewModelImpl:ObservableObject, ForgotPasswordViewModel {
   
    @Published var email : String = ""
    
    
    let service: ForgotPasswordService
    
    private var forgotPWsubcription = Set<AnyCancellable>()

    
    init(service: ForgotPasswordService) {
        self.service = service
    }
    
    
    
    func sendPasswordReset() {
        service
            .sendPasswordReset(to: email)
            .sink { res in
                switch res {
                case .failure(let err):
                    print("failed: \(err)")
                default: break
                }
            } receiveValue: {
                print("Sent password reset request")
            }
            .store(in: &forgotPWsubcription)

    }
    
    
}
