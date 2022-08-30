//
//  NavigationController+Extension.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/08/28.
//

import Foundation
import SwiftUI
extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
