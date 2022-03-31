//
//  KeyboardPublishers.swift
//  Blockster
//
//  Created by Vladimir Bukovskyi on 12.07.2021.
//

import Foundation
import Combine
import UIKit

struct KeyboardInfo {
    var height: CGFloat?
    var duration: Double?
    var willShow: Bool = false
}

struct KeyboardPublishers {
    
    static var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification).map { notif -> CGFloat in
            let rect = notif.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            return rect?.height ?? 0
        }
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification).map { notif -> CGFloat in
            return 0.0
        }
        return Publishers
            .MergeMany(willShow, willHide)
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    static var keyboardDurationPublisher: AnyPublisher<Double, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification).map { notif -> Double in
            let animationDurationValue = notif.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber
            return animationDurationValue?.doubleValue ?? 0.0
        }
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification).map { notif -> Double in
            let animationDurationValue = notif.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber
            return animationDurationValue?.doubleValue ?? 0.0
        }
        return Publishers
            .MergeMany(willShow, willHide)
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    static var keyboardWillShowPublisher: AnyPublisher<Bool, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification).map { notif -> Bool in
            return true
        }
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification).map { notif -> Bool in
            return false
        }
        return Publishers
            .MergeMany(willShow, willHide)
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    static var keyboardInfoPublisher: AnyPublisher<KeyboardInfo, Never> {
        return Publishers
            .CombineLatest3(KeyboardPublishers.keyboardHeightPublisher, KeyboardPublishers.keyboardDurationPublisher, KeyboardPublishers.keyboardWillShowPublisher)
            .map { (height, duration, willShow) -> KeyboardInfo in
                return KeyboardInfo(height: height, duration: duration, willShow: willShow)
            }
            .eraseToAnyPublisher()
    }
}
