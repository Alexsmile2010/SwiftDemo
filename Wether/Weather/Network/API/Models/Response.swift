//
//  Response.swift
//  Admin
//
//  Created by Serhii Palash on 20/01/2021.
//  Copyright © 2021 ForzaFC. All rights reserved.
//

import Foundation

struct Response<T> {
    let value: T
    let response: URLResponse
}
