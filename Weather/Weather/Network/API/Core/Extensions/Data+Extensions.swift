//
//  Data+Extensions.swift
//  Admin
//
//  Created by Volodymyr Ludchenko on 09.03.2021.
//  Copyright © 2021 ForzaFC. All rights reserved.
//

import Foundation

extension Data {
    var prettyPrinted: String? {
        do {
            let object = try JSONSerialization.jsonObject(with: self, options: [])
            let data = try JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted, .withoutEscapingSlashes])
            return String(data: data, encoding: .utf8)
        } catch {
            return String(data: self, encoding: .utf8)
        }
    }
}
