//
//  LoginViewModel.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/15/23.
//

import Foundation
import Combine

enum LoginState {
    case sucessfull
    case failed(error: Error)
    case noverified(erro: Error)
    case na
}

protocol LoginViewModel {
    var hasError: Bool { get }
    func login()
    var service: LoginService { get }
    var state: LoginState { get }
    var credentials: LoginCredentials { get }
    init(service: LoginService)
}

final class LoginViewModelImpl: ObservableObject, LoginViewModel {
    
    
    @Published var hasError: Bool = false
    @Published var state: LoginState = .na
    @Published var credentials: LoginCredentials = LoginCredentials.new
    
    private var loginsubscription = Set<AnyCancellable>()
    
    let service: LoginService
    
    init(service: LoginService) {
        self.service = service
        setupErrorSubscription()
    }
    
    func login() {
        service
            .login(with: credentials)
            .sink { res in
                
                switch res {
                case .failure(let err):
                    self.state = .failed(error: err)
                default: break
                }
            } receiveValue: { [weak self] in
                self?.state = .sucessfull
            }
            .store(in: &loginsubscription)

    }
}

private extension LoginViewModelImpl {
    
    func setupErrorSubscription() {
        
        $state
            .map { state -> Bool in
                    switch state {
                    case .sucessfull,
                            .na:
                        return false
                    case .failed:
                        return true
                    case .noverified:
                        return true
                    }
            }
            .assign(to: &$hasError)
    }
}
