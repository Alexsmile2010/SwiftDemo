//
//  LoadingView.swift
//  Weather
//
//  Created by Alexey Zayakin on 11.04.2022.
//

import UIKit

final class LoadingView: DGTXView {

    enum State {
        case loading
        case hidden
        case error(message: String)
    }
    
    private var currentState: State = .loading
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = AppStyle.Colors.background(.white).color
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var messageLabel = DGTXLabel { label in
        label.setTextFont(.text(.text14))
        label.setTextColor(.text(.white))
        label.textAlignment = .center
    }
    
    private lazy var actionButton = DGTXButton { button in
        button.setTextFont(.text(.text12))
        button.setTextColor(.text(.black))
        button.setBackgroundColor(.background(.white))
        button.setCornerRadius(.medium)
        button.setLocalizedKey(.global(.common(.retry)))
    }
    
    init() {
        super.init(frame: .zero)
        setUpConstraints()
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

//MARK: - ViewInitializtion

extension LoadingView: ViewInitializtion {
    func setUpConstraints() {
        
        let actionLocationButtonBottomOffset = 24.0
        
        addSubviews(loadingIndicator,
                    messageLabel,
                    actionButton)
        
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        messageLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(.sideSpace(.large))
            make.top.equalTo(loadingIndicator.snp.bottom).offset(.betwennItemSpace(.medium))
        }
        
        actionButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(.sideSpace(.large))
            make.bottomMargin.equalToSuperview().inset(.custom(value: actionLocationButtonBottomOffset))
            make.height.equalTo(.itemHeight(.buttonHeight))
        }
    }
    
    func setUpViewModel() {}
    
    func setUpView() {
        setBackgroundColor(.background(.primary))
        applyState(currentState)
    }
}

//MARK: - Public

extension LoadingView {
    
    func applyState(_ state: State) {
        currentState = state
        switch state {
        case .loading:
            applyLoadingState()
        case .error(message: let message):
            applyErrorState(with: message)
        case .hidden:
            isHidden = true
        }
    }
}

//MARK: - Private

extension LoadingView {
    
    private func applyLoadingState() {
        isHidden = false
        loadingIndicator.startAnimating()
        [messageLabel, actionButton].forEach { view in
            view.isHidden = true
        }
    }
    
    private func applyErrorState(with message: String) {
        isHidden = false
        loadingIndicator.stopAnimating()
        [messageLabel, actionButton].forEach { view in
            view.isHidden = false
        }
        messageLabel.text = message
    }
}
