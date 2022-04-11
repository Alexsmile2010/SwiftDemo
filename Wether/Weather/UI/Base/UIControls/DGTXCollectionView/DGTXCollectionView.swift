//
//  DGTXCollectionView.swift
//  Blockster
//
//  Created by Vladimir Bukovskyi on 06.07.2021.
//

import Foundation
import UIKit

protocol DGTCollectionViewFlowLayoutConfigurator: AnyObject {
    var scrollDirection: UICollectionView.ScrollDirection { get set }
    var minimumLineSpacing: CGFloat { get set }
    var minimumInteritemSpacing: CGFloat { get set }
    var headerReferenceSize: CGSize { get set }
    var footerReferenceSize: CGSize { get set }
    var estimatedItemSize: CGSize { get set }
    var sectionInset: UIEdgeInsets { get set }
}

protocol DGTXCollectionViewConfigurator: ViewConfigurator {
    var dataSource: UICollectionViewDataSource? { get set }
    var delegate: UICollectionViewDelegate? { get set }
    var isPagingEnabled: Bool { get set }
    var isScrollEnabled: Bool { get set }
    var showsHorizontalScrollIndicator: Bool { get set }
    var showsVerticalScrollIndicator: Bool { get set }
    
    func registerClass<T: UICollectionViewCell>(_ cellClass: T.Type)
    func showScrollIndicators(_ isShow: Bool)
}

extension DGTXCollectionViewConfigurator where Self: UICollectionView {
    func registerClass<T: UICollectionViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass))
    }
    
    func showScrollIndicators(_ isShow: Bool) {
        showsHorizontalScrollIndicator = isShow
        showsVerticalScrollIndicator = isShow
    }
}

class DGTXCollectionView: UICollectionView {
    init(layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DGTXCollectionView: DGTXCollectionViewConfigurator {
    convenience init(_ layoutConfigurator: (_ layout: DGTCollectionViewFlowLayoutConfigurator) -> Void, collectionViewConfigurator: (_ collectionView: DGTXCollectionViewConfigurator) -> Void) {
        let layout = UICollectionViewFlowLayout(layoutConfigurator)
        self.init(layout: layout)
        collectionViewConfigurator(self)
    }
}

extension UICollectionViewFlowLayout: DGTCollectionViewFlowLayoutConfigurator {
    convenience init(_ configurator: (_ layout: DGTCollectionViewFlowLayoutConfigurator) -> Void) {
        self.init()
        configurator(self)
    }
}
