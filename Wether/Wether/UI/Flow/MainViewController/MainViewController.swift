//
//  MainViewController.swift
//  Wether
//
//  Created by Alexey Zayakin on 31.03.2022.
//

import UIKit

final class MainViewController: BaseViewController {
    
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
    
    private lazy var searchlocationButton = DGTXButton { button in
        button.setImage(.search, renderMode: .alwaysTemplate)
        button.setTintColor(.text(.white))
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
    }
    
    private lazy var wetherImageView = DGTXImageView { imageView in
        imageView.contentMode = .scaleAspectFit
        imageView.setImage(preset: .search)
    }
    
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
        
        view.addSubviews(contentStackView)
        contentStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(.sideSpace(.large))
            make.topMargin.equalToSuperview().inset(.sideSpace(.medium))
        }
        
        [cityLabel, searchlocationButton]
            .embeddedInStackView { stack in
                stack.axis = .horizontal
                stack.setSpacing(.betwennItemSpace(.medium))
            }
            .storeIn(contentStackView, basedOnEmptyView: false)
            
        
        searchlocationButton.snp.makeConstraints { make in
            make.width.height.equalTo(.itemHeight(.buttonHeight))
        }
        
        contentStackView.addArrangedSubview(dateLabel)
        
        let wetherInfoStackView = [temperatureLabel,
                                   humidityLabel,
                                   windLabel]
            .embeddedInStackView { stack in
            stack.axis = .vertical
            }

        wetherInfoStackView.snp.makeConstraints { make in
            make.width.equalTo(view.bounds.width / 2)
        }

        [wetherImageView, wetherInfoStackView]
            .embeddedInStackView { stack in
            stack.axis = .horizontal
        }.storeIn(contentStackView, basedOnEmptyView: false)
        
    }
    
    func setUpViewModel() {
        
    }
    
    func setUpView() {
        setBackgroundColor(.background(.primary))
        cityLabel.text = "Kyiv"
        dateLabel.text = "15 Марта 2015"
        temperatureLabel.text = "-5/1"
        humidityLabel.text = "44%"
        windLabel.text = "5m/s"
        
    }
}

//MARK: - Actions

extension MainViewController {
    
    @objc private func locationButtonTapped() {
        
    }
}
