//
//  Screen1_ProgressIndicatorManager.swift
//  Final Project - Allergytics
//
//  Created by Yuna Watanabe on 12/8/25.
//

import UIKit

extension Screen1_signInVC: ProgressSpinnerDelegate {
    func showActivityIndicator() {
        // MARK: - Add the indicator VC as child VC
        addChild(childProgressView)
        // MARK: - Add the indicator view as a sub view
        view.addSubview(childProgressView.view)
        // MARK: - Let the child view know that it's attached to its parent
        childProgressView.didMove(toParent: self)
    }
    
    func hideActivityIndicator() {
        // MARK: - Let the child view know that it's detached from its parent
        childProgressView.willMove(toParent: nil)
        // MARK: - Remove the indicator view from the parent view
        childProgressView.view.removeFromSuperview()
        // MARK: - Remove the indicator VC from its parent VC
        childProgressView.removeFromParent()
    }
}
