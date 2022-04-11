//
//  LoadingViewController.swift
//  Weather
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
    
    private lazy var userLocationLabel = DGTXLabel { label in
        label.setTextColor(.text(.white))
        label.setTextFont(.heading(.headline18))
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
    }
    
    private lazy var allowLocationButton = DGTXButton { button in
        button.setBackgroundColor(.background(.white))
        button.setCornerRadius(.medium)
        button.setLocalizedKey(.welcome(.enableLocation))
        button.setTextColor(.text(.black))
        button.setTextFont(.text(.text14))
        button.addTarget(self, action: #selector(allowLocationButtonTapped), for: .touchUpInside)
    }
    
    private lazy var nextButton = DGTXButton { button in
        button.setBackgroundColor(.background(.white))
        button.setCornerRadius(.medium)
        button.setLocalizedKey(.welcome(.nextButton))
        button.setTextColor(.text(.black))
        button.setTextFont(.text(.text14))
        button.isHidden = true
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    private let viewModel = WelcomeViewControllerViewModel()

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
        
        view.addSubviews(allowLocationButton,
                         userLocationLabel,
                         nextButton)
        
        allowLocationButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(.sideSpace(.large))
            make.bottomMargin.equalToSuperview().inset(.custom(value: allowLocationButtonBottomOffset))
            make.height.equalTo(.itemHeight(.buttonHeight))
        }
        
        [userLocationLabel, nextButton].embeddedInStackView { stack in
            stack.axis = .horizontal
            stack.setSpacing(.betwennItemSpace(.medium))
        }
        .storeIn(view)
        .snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(.sideSpace(.large))
            make.center.equalToSuperview()
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
        viewModel.onDidReceiveUserLocation = { [weak self] city in
            self?.handleUserLocation(city)
        }
        
        viewModel.onDidChangeAuthorizationStatus = { [weak self] buttonTitle in
            self?.handleLocationButtonStateTitle(buttonTitle)
        }
        
        viewModel.onDidFailReceivePermissionOrLocation = { [weak self] in
            self?.presentErrorAlert()
        }
        
        viewModel
            .nextButtonIsHidden
            .sink { [weak self] isHidden in
            self?.nextButton.isHidden = isHidden
        }
            .store(in: &bag)
    }
    
    func setUpView() {
        setBackgroundColor(.background(.primary))
    }
}

//MARK: - Private

extension WelcomeViewController {
    
    private func handleUserLocation(_ location: String?) {
        userLocationLabel.text = location
    }
    
    private func handleLocationButtonStateTitle(_ key: LOCKey) {
        allowLocationButton.setLOCKey(key)
    }
    
    private func presentErrorAlert() {
        let alertTitle = LOCService.localize(with: .welcome(.errorAlertTitle))
        let alertDesc = LOCService.localize(with: .welcome(.errorAlertDesc))
        let searchButtonTitle = LOCService.localize(with: .welcome(.errorAlertSearchButton))
        let skipButtonTitle = LOCService.localize(with: .welcome(.errorAlertSkipButton))
        
        let alert = UIAlertController(title: alertTitle,
                                      message: alertDesc,
                                      preferredStyle: .alert)
        let searchAction = UIAlertAction(title: searchButtonTitle,
                                         style: .default) { [weak self] _ in
            self?.searchButtonTapped()
        }
        
        let skipAction = UIAlertAction(title: skipButtonTitle,
                                       style: .default) { [weak self] _ in
            self?.skipButtonTapped()
        }
        
        alert.addAction(searchAction)
        alert.addAction(skipAction)
        present(alert,
                animated: true)
    }
}

//MARK: - Actions

extension WelcomeViewController {
    
    @objc private func allowLocationButtonTapped() {
        viewModel.requestLocationStatus()
    }
    
    @objc private func nextButtonTapped() {
        AppNavigation(type: .root(settings: viewModel.mainScreenTransitionSettings))
            .navigate()
    }
    
    private func searchButtonTapped() {
        
    }
    
    private func skipButtonTapped() {
        
    }
}
