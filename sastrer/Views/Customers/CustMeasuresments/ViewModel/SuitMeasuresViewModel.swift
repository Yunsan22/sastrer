//
//  SuitMeasuresViewModel.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/10/23.
//


import Foundation
import Combine

enum SuitMeasuresCreationState {
    case successfull
    case failed(error: Error)
    case na
}

protocol SuitMeasuresCreationViewModel {
    func suitMeasuresCreation()
    var suitService: SuitMeasuresService {get}
    var state: SuitMeasuresCreationState { get }
    var suitMeasurementDetails: SuitMeasuresDetails { get }
    init (service: SuitMeasuresService)
    
}

final class SuitMeasuresDataCreationViewModelImpl: ObservableObject, SuitMeasuresCreationViewModel {
    
    
    let suitService: SuitMeasuresService
    var state: SuitMeasuresCreationState = .na
    @Published var suitMeasurementDetails: SuitMeasuresDetails = SuitMeasuresDetails.new
    
    private var suitSubscriptions = Set<AnyCancellable>()
    
        var isValid: Bool {
            !suitMeasurementDetails.manShirtsMeasurments.fistWidth.isEmpty &&
            !suitMeasurementDetails.manShirtsMeasurments.back.isEmpty
        }
    func clearAll() {
        self.suitMeasurementDetails = .new
        
    }
    
    init(service: SuitMeasuresService) {
        self.suitService = service
        
    }
    func suitMeasuresCreation() {
        suitService
            .createMeasures(with: suitMeasurementDetails)
            .sink { [weak self] res in
                switch res {
                case .failure(let error):
                    self?.state = .failed(error: error)
                default: break
                }
            } receiveValue: { [weak self] in
                self?.state = .successfull
            }
            .store(in: &suitSubscriptions)
        
    }
}
