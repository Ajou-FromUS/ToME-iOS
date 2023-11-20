//
//  UserDefaultKeyList.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/10.
//

import Foundation

struct UserDefaultKeyList {
    struct Auth {
        @UserDefaultWrapper<Bool>(key: "didSignIn") public static var didSignIn
    }
}
