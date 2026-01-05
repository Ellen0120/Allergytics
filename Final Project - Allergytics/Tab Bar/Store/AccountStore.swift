//
//  AccountStore.swift
//  Final Project - Allergytics
//
//  Created by Yuna Watanabe on 11/19/25.
//

import Foundation
import UIKit

class AccountStore {
    static let shared = AccountStore()
    private init() {}
    
    var account: UserInfo?
    var photo: UIImage?
}
