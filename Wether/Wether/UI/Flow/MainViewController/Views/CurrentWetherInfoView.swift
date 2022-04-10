//
//  CurrentWetherInfoView.swift
//  Wether
//
//  Created by Alexey Zayakin on 08.04.2022.
//

import UIKit
import Nuke

struct CurrentWetherDisplayData {
    let temperature: String?
    let humidity: String?
    let wind: String?
    let iconUrl: URL?
    let description: String?
}

final class CurrentWetherInfoView: DGTXView {
    
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
    
    private lazy var wetherImageView = DGTXImageView { imageView in
        imageView.contentMode = .scaleAspectFit
    }
    
    private lazy var wetherDescLabel = DGTXLabel { label in
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

extension CurrentWetherInfoView: ViewInitializtion {
    
    func setUpConstraints() {
        
        let wetherInfoStackView = [temperatureLabel,
                                   humidityLabel,
                                   windLabel]
            .embeddedInStackView { stack in
                stack.axis = .vertical
            }
        
        let wetherIconDescStackView = [wetherImageView, wetherDescLabel]
            .embeddedInStackView { stack in
                stack.axis = .vertical
                stack.setSpacing(.betwennItemSpace(.small))
            }
        
        [wetherIconDescStackView, wetherInfoStackView]
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

extension CurrentWetherInfoView {
    
    func reloadData(with data: CurrentWetherDisplayData) {
        temperatureLabel.text = data.temperature
        humidityLabel.text = data.humidity
        windLabel.text = data.wind
        wetherDescLabel.text = data.description
        
        if let url = data.iconUrl {
            wetherImageView.image = nil
            Nuke.loadImage(with: url, into: wetherImageView)
        }
    }
}

