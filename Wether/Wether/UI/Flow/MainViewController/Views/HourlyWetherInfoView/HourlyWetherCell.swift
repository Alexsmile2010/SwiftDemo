//
//  HourlyWetherCell.swift
//  Wether
//
//  Created by Alexey Zayakin on 10.04.2022.
//

import UIKit
import Nuke

struct HurlyDisplayData {
    let hour: String?
    let temperature: String?
    let iconUrl: URL?
}

final class HourlyWetherCell: DGTXCollectionViewCell {
    
    private let hourLabel = DGTXLabel { label in
        label.setTextFont(.text(.text12))
        label.setTextColor(.text(.white))
        label.textAlignment = .center
    }
    
    private let temperatureLabel = DGTXLabel { label in
        label.setTextFont(.text(.text12))
        label.setTextColor(.text(.white))
        label.textAlignment = .center
    }
    
    private let iconImageView = DGTXImageView { imageView in
        imageView.contentMode = .scaleToFill
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        iconImageView.image = nil
        super.prepareForReuse()
    }
}

//MARK: - ViewInitializtion

extension HourlyWetherCell: ViewInitializtion {
    
    func setUpConstraints() {
        [hourLabel, iconImageView, temperatureLabel]
            .embeddedInStackView { stack in
                stack.axis = .vertical
            }
            .storeIn(self)
            .snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        
        hourLabel.snp.makeConstraints { make in
            make.height.equalTo(.itemHeight(.hourlyCellLabelHeight))
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.height.equalTo(.itemHeight(.hourlyCellLabelHeight))
        }
    }
    
    func setUpViewModel() {}
    func setUpView() {}
}

//MARK: - Public

extension HourlyWetherCell {
    
    func setCell(with data: HurlyDisplayData?) {
        temperatureLabel.text = data?.temperature
        hourLabel.text = data?.hour
        
        if let url = data?.iconUrl {
            Nuke.loadImage(with: url, into: iconImageView)
        }
    }
}
