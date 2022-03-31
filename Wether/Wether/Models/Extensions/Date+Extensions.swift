//
//  Date+Extensions.swift
//  Blockster
//
//  Created by Vladimir Bukovskyi on 23.07.2021.
//

import Foundation

extension Date {
    
    func defaultFormat() -> String {
        return DateFormatter.defaultFormatter().string(from: self)
    }
    
    func serverFormat() -> String {
        return DateFormatter.serverFormatter().string(from: self)
    }
}

extension DateFormatter {
    
    static func defaultFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }
    
    static func serverFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
}
