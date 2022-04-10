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
    
    func customFormat(_ format: DateFormatter.DateFormat) -> String {
        return DateFormatter.custom(with: format).string(from: self)
    }
}

extension DateFormatter {
    
    enum DateFormat: String {
        ///mon. 19 2021
        case EEdyyyy = "EE .d yyyy"
        ///00:00
        case HHmm = "HH:mm"
    }
    
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
    
    static func custom(with format: DateFormat) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter
    }
}
