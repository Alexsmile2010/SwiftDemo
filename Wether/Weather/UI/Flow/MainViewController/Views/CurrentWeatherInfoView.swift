//
//  CurrentWeatherInfoView.swift
//  Weather
//
//  Created by Alexey Zayakin on 08.04.2022.
//

import UIKit
import Nuke

struct CurrentWeatherDisplayData {
    let temperature: String?
    let humidity: String?
    let wind: String?
    let iconUrl: URL?
    let description: String?
}

final class CurrentWeatherInfoView: DGTXView {
    
    private lazy var temperatureLabel = DGTXLabel { label in
        label.setTextFont(.heading(.headline24))
        label.setTextColor(.text(.white))
    }
    
    private lazy var humidityLabel = DGTXLabel { label in
        label.setTextFont(.heading(.headline24))
        label.setTextColor(.text(.white))
    }
    
    private lazy var windLabel = DGTXLabel { label in
        label.setTextFont(.heading(.headline24))
        label.setTextColor(.text(.white))
    }
    
    private lazy var weatherImageView = DGTXImageView { imageView in
        imageView.contentMode = .scaleAspectFit
    }
    
    private lazy var weatherDescLabel = DGTXLabel { label in
        label.setTextFont(.text(.text12))
        label.setTextColor(.text(.white))
        label.textAlignment = .center
    }
    
    init() {
        super.init(frame: .zero)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

//MARK: - ViewInitializtion

extension CurrentWeatherInfoView: ViewInitializtion {
    
    func setUpConstraints() {
        
        let weatherInfoStackView = [temperatureLabel,
                                   humidityLabel,
                                   windLabel]
            .embeddedInStackView { stack in
                stack.axis = .vertical
            }
        
        let weatherIconDescStackView = [weatherImageView, weatherDescLabel]
            .embeddedInStackView { stack in
                stack.axis = .vertical
                stack.setSpacing(.betwennItemSpace(.small))
            }
        
        [weatherIconDescStackView, weatherInfoStackView]
            .embeddedInStackView { stack in
                stack.axis = .horizontal
            }
            .storeIn(self)
            .snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
    }
    
    func setUpViewModel() {}
    
    func setUpView() {}
}

//MARK: - Public

extension CurrentWeatherInfoView {
    
    func reloadData(with data: CurrentWeatherDisplayData) {
        temperatureLabel.text = data.temperature
        humidityLabel.text = data.humidity
        windLabel.text = data.wind
        weatherDescLabel.text = data.description
        
        if let url = data.iconUrl {
            weatherImageView.image = nil
            Nuke.loadImage(with: url, into: weatherImageView)
        }
    }
}

