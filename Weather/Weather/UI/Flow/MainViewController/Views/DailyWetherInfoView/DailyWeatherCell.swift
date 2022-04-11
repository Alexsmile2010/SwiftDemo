//
//  DailyWeatherCell.swift
//  Weather
//
//  Created by Alexey Zayakin on 11.04.2022.
//

import UIKit
import Nuke

final class DailyWeatherCell: DGTXTableViewCell {
    
    private lazy var dayLabel = DGTXLabel { label in
        label.setTextFont(.text(.text14))
        label.setTextColor(.text(.black))
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private lazy var temperatureLebel = DGTXLabel { label in
        label.setTextFont(.text(.text14))
        label.setTextColor(.text(.black))
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
    private lazy var weatherImageView = DGTXImageView { imageView in
        imageView.contentMode = .scaleAspectFit
    }
    
    override func prepareForReuse() {
        weatherImageView.image = nil
        super.prepareForReuse()
    }
    
    override func setUpConstraints() {
        [dayLabel, temperatureLebel, weatherImageView]
            .embeddedInStackView { stack in
                stack.axis = .horizontal
                stack.setSpacing(.betwennItemSpace(.medium))
            }
            .storeIn(contentView)
            .snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(.sideSpace(.medium))
            }
        
        weatherImageView.snp.makeConstraints { make in
            make.width.equalTo(.itemHeight(.buttonHeight))
        }
    }
    
    func setCell(with data: DailyDisplayInfoData?) {
        dayLabel.text = data?.day
        temperatureLebel.text = data?.temperature
        
        if let url = data?.iconUrl {
            Nuke
                .loadImage(with: url,
                           into: weatherImageView)
        }
        
    }
}
