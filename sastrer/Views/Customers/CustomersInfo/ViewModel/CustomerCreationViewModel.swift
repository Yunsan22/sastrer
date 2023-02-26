//
//  CustomerCreationViewModel.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/10/23.
//

import Foundation
import Combine

enum CustomerCreationState {
    case successfull
    case failed(error: Error)
    case na
}

protocol CustomerCreaionViewModel {
    func custumerCreation()
    var service: CustDetailsAndMeasuresService {get}
    var state: CustomerCreationState { get }
    var customerDetails: CustomersMeasurementsAndDetails { get }
    init (service: CustDetailsAndMeasuresService)
    
}

final class CustomerCreationViewModelImpl: ObservableObject, CustomerCreaionViewModel {
    
    
    let service: CustDetailsAndMeasuresService
    var state: CustomerCreationState = .na
    @Published var customerDetails: CustomersMeasurementsAndDetails = CustomersMeasurementsAndDetails.new
    
    private var subscriptions = Set<AnyCancellable>()
    
    var isValid: Bool {
        !customerDetails.clientInfo.firstName.isEmpty &&
//        !customerDetails.clientInfo.lastName.isEmpty &&
        !customerDetails.clientInfo.phone.isEmpty &&
        !customerDetails.clientInfo.comments.isEmpty
    }
    func clearAll() {
        self.customerDetails = .new
        
    }
    
    init(service: CustDetailsAndMeasuresService) {
        self.service = service
        
    }
    func custumerCreation() {
        service
            .createCustomers(with: customerDetails)
            .sink { [weak self] res in
                switch res {
                case .failure(let error):
                    self?.state = .failed(error: error)
                default: break
                }
            } receiveValue: { [weak self] in
                self?.state = .successfull
            }
            .store(in: &subscriptions)

    }
}

