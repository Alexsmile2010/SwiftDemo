//
//  ParametersEncoder.swift
//  Admin
//
//  Created by Serhii Palash on 20/01/2021.
//  Copyright © 2021 ForzaFC. All rights reserved.
//

import Foundation

typealias Parameters = [String: Any]

protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
