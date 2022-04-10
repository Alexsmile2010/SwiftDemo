//
//  MainViewController.swift
//  Wether
//
//  Created by Alexey Zayakin on 31.03.2022.
//

import UIKit
import Nuke

final class MainViewController: BaseViewController {
    
    private lazy var contentStackView = DGTXStackView { stack in
        stack.axis = .vertical
        stack.setSpacing(.betwennItemSpace(.medium))
    }
    
    private let wetherInfoView = CurrentWetherInfoView()
    private let wetherLocationInfoView = WetherLocationInfoView()
    private let wetherHourlyInfoView = HourlyWetherInfoView()
    
    private var viewModel: MainViewControllerViewModel
    
    init(with viewModel: MainViewControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConstraints()
        setUpViewModel()
        setUpView()
    }
}

extension MainViewController: ViewInitializtion {
    
    func setUpConstraints() {
        
        view.addSubviews(contentStackView,
                         wetherHourlyInfoView)
        
        contentStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(.sideSpace(.large))
            make.topMargin.equalToSuperview().inset(.sideSpace(.medium))
        }
        
        contentStackView.addArrangedSubview(wetherLocationInfoView)
        contentStackView.addArrangedSubview(wetherInfoView)
        
        wetherHourlyInfoView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(contentStackView.snp.bottom)
        }
    }
    
    func setUpViewModel() {
        viewModel
            .onNeedToReloadCurrentWetherData = { [weak wetherInfoView] data in
            wetherInfoView?
                    .reloadData(with: data)
        }
        
        viewModel
            .onNeedToReloadWetherLocationData = { [weak wetherLocationInfoView] data in
            wetherLocationInfoView?
                    .reloadData(with: data)
        }
        
        viewModel
            .onNeedToRealoadHourlyWetherData = { [weak wetherHourlyInfoView] viewModel in
            wetherHourlyInfoView?
                    .reloadData(with: viewModel)
        }
    }
    
    func setUpView() {
        setBackgroundColor(.background(.primary))
        wetherLocationInfoView.delegate = self
        viewModel.getWether()
    }
}

//MARK: - Private

extension MainViewController {
    private func handleWetherData(_ data: WetherEntity?) {

    }
}

extension MainViewController: WetherLocationInfoViewDelegate {
    
    func wetherLocationInfoViewSearchButtonTapped() {
        //do nothing
    }
}
