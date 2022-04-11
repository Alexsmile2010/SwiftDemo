//
//  CancelableViewModel.swift
//  Blockster
//
//  Created by Alexey Zayakin on 07.09.2021.
//

import Foundation
import Combine

class CancelableViewModel: BaseViewModel {
    lazy var bag: Set<AnyCancellable> = []
    
    deinit {
        print("\(String(describing: self)) deinit")
        bag.forEach({$0.cancel()})
    }
}
