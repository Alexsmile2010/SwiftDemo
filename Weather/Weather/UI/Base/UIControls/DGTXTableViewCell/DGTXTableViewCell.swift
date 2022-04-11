//
//  DGTXTableViewCell.swift
//  Blockster
//
//  Created by Vladimir Bukovskyi on 22.06.2021.
//

import UIKit
import Combine

class DGTXTableViewCell: UITableViewCell, ViewInitializtion {
    
    
    lazy var bag = Set<AnyCancellable>()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
        setUpConstraints()
        setUpViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        bag.forEach({$0.cancel()})
    }
    
    func setUpConstraints() {
        
    }
    
    func setUpViewModel() {
        
    }
    
    func setUpView() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
}
