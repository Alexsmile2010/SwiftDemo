//
//  MainViewController.swift
//  Weather
//
//  Created by Alexey Zayakin on 31.03.2022.
//

import UIKit
import Nuke

final class MainViewController: BaseViewController {
    
    private lazy var contentStackView = DGTXStackView { stack in
        stack.axis = .vertical
        stack.setSpacing(.betwennItemSpace(.medium))
        stack.isHidden = true
    }
    
    private let weatherInfoView = CurrentWeatherInfoView()
    private let weatherLocationInfoView = WeatherLocationInfoView()
    private let weatherHourlyInfoView = HourlyWeatherInfoView()
    private let dailyWeatherInfoView = DailyWeatherInfoView()
    
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
                         weatherHourlyInfoView,
                         dailyWeatherInfoView)
        
        contentStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(.sideSpace(.large))
            make.topMargin.equalToSuperview().inset(.sideSpace(.medium))
        }
        
        contentStackView.addArrangedSubview(weatherLocationInfoView)
        contentStackView.addArrangedSubview(weatherInfoView)
        
        weatherHourlyInfoView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(contentStackView.snp.bottom)
        }
        
        dailyWeatherInfoView.snp.makeConstraints { make in
            make.top.equalTo(weatherHourlyInfoView.snp.bottom)
            make.leading.trailing.bottomMargin.equalToSuperview()
        }
    }
    
    func setUpViewModel() {
        viewModel
            .onNeedToReloadCurrentWeatherData = { [weak weatherInfoView] data in
            weatherInfoView?
                    .reloadData(with: data)
        }
        
        viewModel
            .onNeedToReloadWeatherLocationData = { [weak weatherLocationInfoView] data in
            weatherLocationInfoView?
                    .reloadData(with: data)
        }
        
        viewModel
            .onNeedToRealoadHourlyWeatherData = { [weak weatherHourlyInfoView] viewModel in
            weatherHourlyInfoView?
                    .reloadData(with: viewModel)
        }
        
        viewModel
            .onNeedToRealoadDailyWeatherData = { [weak dailyWeatherInfoView] viewModel in
            dailyWeatherInfoView?
                .reloadData(with: viewModel)
        }
        
        viewModel.onDidFinishLoading = { [weak self] error in
            self?.handleError(error)
        }
    }
    
    func setUpView() {
        setBackgroundColor(.background(.primary))
        weatherLocationInfoView.delegate = self
        viewModel.getWeather()
    }
}

//MARK: - Private

extension MainViewController {
    private func handleError(_ error: RequestError) {
        //handle error and display error state
    }
}

extension MainViewController: WeatherLocationInfoViewDelegate {
    
    func weatherLocationInfoViewSearchButtonTapped() {
        //do nothing
    }
}
