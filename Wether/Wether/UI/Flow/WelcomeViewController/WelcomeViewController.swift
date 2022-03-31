//
//  LoadingViewController.swift
//  Wether
//
//  Created by Alexey Zayakin on 31.03.2022.
//

import UIKit

final class WelcomeViewController: BaseViewController {
    
    private lazy var helloLabel = DGTXLabel { label in
        label.setTextColor(.text(.white))
        label.setLocalizedKey(.welcome(.hello))
        label.setTextFont(.heading(.headline38))
    }
    
    private lazy var welcomeLabel = DGTXLabel { label in
        label.setTextColor(.text(.white))
        label.setLocalizedKey(.welcome(.welcomeMessage))
        label.setTextFont(.heading(.headline18))
        label.numberOfLines = 0
    }
    
    private lazy var allowLocationButton = DGTXButton { button in
        button.setBackgroundColor(.background(.white))
        button.setCornerRadius(.medium)
        button.setLocalizedKey(.welcome(.enableLocation))
        button.setTextColor(.text(.black))
        button.setTextFont(.text(.text14))
        button.addTarget(self, action: #selector(allowLocationButtonTapped), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConstraints()
        setUpView()
        setUpViewModel()
    }
}

extension WelcomeViewController: ViewInitializtion {
    func setUpConstraints() {
        
        let stackViewTopOffset = 50.0
        let allowLocationButtonBottomOffset = 24.0
        
        view.addSubviews(allowLocationButton)
        
        allowLocationButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(.sideSpace(.large))
            make.bottomMargin.equalToSuperview().inset(.custom(value: allowLocationButtonBottomOffset))
            make.height.equalTo(.itemHeight(.buttonHeight))
        }
        
        [helloLabel, welcomeLabel].embeddedInStackView { stack in
            stack.axis = .vertical
            stack.setSpacing(.betwennItemSpace(.medium))
        }
        .storeIn(view)
        .snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(.sideSpace(.large))
            make.top.equalToSuperview().inset(.custom(value: stackViewTopOffset))
        }
    }
    
    func setUpViewModel() {
        
    }
    
    func setUpView() {
        setBackgroundColor(.background(.primary))
    }
}

//MARK: - Actions

extension WelcomeViewController {
    
    @objc private func allowLocationButtonTapped() {
        
    }
}
