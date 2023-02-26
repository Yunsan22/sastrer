//
//  RegistrationViewModel.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/13/23.
//

import Foundation
import Combine

enum RegistrationState {
    case successfull
    case failed(error: Error)
    case noverified(erro: Error)
    case na
}


protocol RegistrationViewModel {
    var hasError: Bool { get }
    func register()
    var service: RegistrationService { get }
    var state: RegistrationState { get }
    var userDetails: RegistrationDetails { get }
    init(service: RegistrationService)
    
}

final class RegistrationViewModelImpl: ObservableObject, RegistrationViewModel {
    
    @Published var hasError: Bool = false
    @Published var state: RegistrationState = .na
    @Published var userDetails: RegistrationDetails = RegistrationDetails.new
    
    private var RegistrationSubscription = Set<AnyCancellable>()
    
    let service: RegistrationService
    
    init(service: RegistrationService) {
        self.service = service
        setupErrorSubscription()
    }
    
    func register() {
        
        service
            .register(with: userDetails)
            .sink { [weak self] res in
                
                switch res {
                case .failure(let error):
                    self?.state = .failed(error: error)
                default: break
                }
            } receiveValue: { [weak self] in
                self?.state = .successfull
            }
            .store(in: &RegistrationSubscription)

    }
}

private extension RegistrationViewModelImpl {
    
    func setupErrorSubscription() {
        
        $state
            .map { states -> Bool in
                
                switch states {
                case .successfull,
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
