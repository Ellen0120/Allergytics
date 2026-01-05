//
//  Screen4_progressIndicatorManager.swift
//  Final Project - Allergytics
//
//  Created by Yuna Watanabe on 12/8/25.
//

import UIKit

extension Screen4_VC: ProgressSpinnerDelegate {
    func showActivityIndicator() {
        // MARK: - Add the indicator VC as a child VC
        addChild(childProgressView)
        // MARK: - Add the indicator view to the parent view
        view.addSubview(childProgressView.view)
        // MARK: - Let the child view know that it's attached to its parent
        childProgressView.didMove(toParent: self)
    }
    
    func hideActivityIndicator() {
        // MARK: - Let the child view know that it's detached from its parent
        childProgressView.willMove(toParent: nil)
        // MARK: - Remove child view from its parent view
        childProgressView.view.removeFromSuperview()
        // MARK: - Remove child VC from its parent VC
        childProgressView.removeFromParent()
    }
}
