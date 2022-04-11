//
//  ListProtocol.swift
//  DGTX
//
//  Created by Alexey Zayakin on 12.04.2021.
//

import Foundation
import CoreGraphics

///Protocol fro define required and optional functions for base list view controller
@objc protocol ListDataSource {
    
    func numberOfRowsIn(section: Int) -> Int
    func numberOfSections() -> Int
    
    @objc optional func heightForRowAt(indexPath: IndexPath) -> CGFloat
    @objc optional func heightForHeaderIn(section: Int) -> CGFloat
    @objc optional func heightForFooterIn(section: Int) -> CGFloat
}

protocol ListDelegate {
    func didSelectRow(at indexPath: IndexPath)
}


