//
//  HourlyWeatherInfoView.swift
//  Weather
//
//  Created by Alexey Zayakin on 10.04.2022.
//

import UIKit

 

final class HourlyWeatherInfoView: DGTXView {

    private lazy var collectionView = DGTXCollectionView { layout in
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
    } collectionViewConfigurator: { collectionView in
        collectionView.registerClass(HourlyWeatherCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.setBackgroundColor(.background(.secondary))
    }
    
    private var viewModel: HourlyWeatherInfoViewModel? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    init() {
        super.init(frame: .zero)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

//MARK: - Public

extension HourlyWeatherInfoView {
    
    func reloadData(with viewModel: HourlyWeatherInfoViewModel?) {
        self.viewModel = viewModel
    }
}

//MARK: - ViewInitializtion

extension HourlyWeatherInfoView: ViewInitializtion {
    
    func setUpConstraints() {
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(.itemHeight(.hourlyCollectionViewHeight))
        }
    }
    
    func setUpViewModel() {}
    func setUpView() {
        setBackgroundColor(.background(.secondary))
    }
}

//MARK: - UICollectionViewDataSource

extension HourlyWeatherInfoView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?
            .numberOfRowsIn(section: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return configureCell(at: indexPath)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension HourlyWeatherInfoView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel?.collectioViewCellSize ?? .zero
    }
}

//MARK: - Private

extension HourlyWeatherInfoView {
    
    private func configureCell(at indexPath: IndexPath) -> UICollectionViewCell {
        let data = viewModel?.hurlyDisplayData(at: indexPath)
        return collectionView.dequeue(HourlyWeatherCell.self,
                                      for: indexPath)
        .configure { cell in
            cell.setCell(with: data)
        }
    }
}

