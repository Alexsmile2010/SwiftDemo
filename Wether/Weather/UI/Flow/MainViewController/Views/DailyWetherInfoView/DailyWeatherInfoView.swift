//
//  DailyWeatherInfoView.swift
//  Weather
//
//  Created by Alexey Zayakin on 11.04.2022.
//

import UIKit

final class DailyWeatherInfoView: DGTXView {
    
    private lazy var tableView : DGTXTableView = {
        let tableView = DGTXTableView()
        tableView.registerClass(DailyWeatherCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    private var viewModel: DailyWeatherViewModel? {
        didSet {
            tableView.reloadData()
        }
    }
    
    init() {
        super.init(frame: .zero)
        setUpConstraints()
        setUpView()
        setUpViewModel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

//MARK: - ViewInitializtion

extension DailyWeatherInfoView: ViewInitializtion {
    
    func setUpConstraints() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setUpViewModel() {}
    
    func setUpView() {
        setBackgroundColor(.background(.white))
    }
}

//MARK: - UITableViewDataSource

extension DailyWeatherInfoView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?
            .numberOfRowsIn(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureCell(at: indexPath)
    }
}

//MARK: - UITableViewDelegate

extension DailyWeatherInfoView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AppLayout.cellHeight(.daily).value
    }
}

//MARK: - Private

extension DailyWeatherInfoView {
    
    private func configureCell(at indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel?.dailyData(at: indexPath)
        let cell = tableView.dequeue(DailyWeatherCell.self, for: indexPath).configure { cell in
            cell.setCell(with: data)
        }
        
        return cell
    }
}

//MARK: - Public

extension DailyWeatherInfoView {
    
    func reloadData(with viewModel: DailyWeatherViewModel) {
        self.viewModel = viewModel
    }
}

