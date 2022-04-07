//
//  MainViewModel.swift
//  Wether
//
//  Created by Alexey Zayakin on 04.04.2022.
//

import Foundation
import CoreLocation

final class MainViewControllerViewModel: CancelableViewModel  {
    
    private var location: CLLocation
    private let networkManager = WetherNetworkManager()
    private var data: WetherEntity?
    
    var onDidFinishLoadData: ((_ data: WetherEntity?) -> Void)?
    
    init(with location: CLLocation) {
        self.location = location
    }
    
    func getWether() {
        networkManager
            .getWether(from: location)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                default:
                    break
                }
        } receiveValue: { [weak self] wetherData in
            self?.handleRequestResponse(with: wetherData)
        }
        .store(in: &bag)

    }
}

//MARK: - Private

extension MainViewControllerViewModel {
    private func handleRequestResponse(with data: WetherEntity) {
        self.data = data
        onDidFinishLoadData?(self.data)
    }
}
