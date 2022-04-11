//
//  BaseViewController.swift
//  Weather
//
//  Created by Alexey Zayakin on 31.03.2022.
//

import UIKit
import Combine

class BaseViewController: UIViewController {

    lazy var bag = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - ViewController public

extension BaseViewController {
    
    func setBackgroundColor(_ colorStyle: AppStyle.Colors) {
        view.backgroundColor = colorStyle.color
    }
}


