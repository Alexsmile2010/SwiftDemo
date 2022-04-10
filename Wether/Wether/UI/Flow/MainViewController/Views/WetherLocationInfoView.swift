//
//  WetherLocationInfoView.swift
//  Wether
//
//  Created by Alexey Zayakin on 08.04.2022.
//

import UIKit

struct WetherLocationInfoData {
    let location: String?
    let date: String?
}

protocol WetherLocationInfoViewDelegate: AnyObject {
    func wetherLocationInfoViewSearchButtonTapped()
}

final class WetherLocationInfoView: DGTXView {
    
    private lazy var contentStackView = DGTXStackView { stack in
        stack.axis = .vertical
        stack.setSpacing(.betwennItemSpace(.medium))
    }
    
    private lazy var cityLabel = DGTXLabel { label in
        label.setTextFont(.heading(.headline24))
        label.setTextColor(.text(.white))
    }
    
    private lazy var dateLabel = DGTXLabel { label in
        label.setTextFont(.text(.text14))
        label.setTextColor(.text(.white))
    }
    
    private lazy var searchlocationButton = DGTXButton { button in
        button.setImage(.search, renderMode: .alwaysTemplate)
        button.setTintColor(.text(.white))
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
    }
    
    weak var delegate: WetherLocationInfoViewDelegate?
    
    init() {
        super.init(frame: .zero)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

//MARK: - ViewInitializtion

extension WetherLocationInfoView: ViewInitializtion {
    
    func setUpConstraints() {
        addSubview(contentStackView)
        
        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        [cityLabel, searchlocationButton].embeddedInStackView { stack in
            stack.axis = .horizontal
            stack.setSpacing(.betwennItemSpace(.small))
        }
        .storeIn(contentStackView,
                 basedOnEmptyView: false)

        searchlocationButton.snp.makeConstraints { make in
            make.width.height.equalTo(.itemHeight(.buttonHeight))
        }
        
        contentStackView.addArrangedSubview(dateLabel)
    }
    
    func setUpViewModel() {}
    
    func setUpView() {}
}

//MARK: - Public

extension WetherLocationInfoView {
    
    func reloadData(with data: WetherLocationInfoData) {
        cityLabel.text = data.location
        dateLabel.text = data.date
    }
}

//MARK: - Actions

extension WetherLocationInfoView {
    
    @objc private func locationButtonTapped() {
        delegate?.wetherLocationInfoViewSearchButtonTapped()
    }
}
