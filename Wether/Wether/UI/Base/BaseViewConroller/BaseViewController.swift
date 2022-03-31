//
//  BaseViewController.swift
//  Wether
//
//  Created by Alexey Zayakin on 31.03.2022.
//

import UIKit

class BaseViewController: UIViewController {

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


