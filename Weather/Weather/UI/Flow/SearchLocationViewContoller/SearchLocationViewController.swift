//
//  SearchLocationViewController.swift
//  Weather
//
//  Created by Alexey Zayakin on 02.04.2022.
//

import UIKit

final class SearchLocationViewController: BaseViewController {
    
    private lazy var containerView = DGTXView { view in
        view.setBackgroundColor(.background(.primary))
    }
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

//MARK: - ViewInitializtion

extension SearchLocationViewController: ViewInitializtion {
    
    func setUpConstraints() {
        
    }
    
    func setUpViewModel() {
        
    }
    
    func setUpView() {
        
    }
}
