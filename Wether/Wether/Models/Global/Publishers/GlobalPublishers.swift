//
//  GlobalPublishers.swift
//  DGTX
//
//  Created by Alexey Zayakin on 24.03.2021.
//

import Foundation
import Combine
import CoreLocation

struct GlobalPublishers {
    static let currentLocation = CurrentValueSubject<CLPlacemark?, Never>(nil)
}
