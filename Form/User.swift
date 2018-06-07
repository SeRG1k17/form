//
//  User.swift
//  Form
//
//  Created by Sergey Pugach on 07.06.2018.
//  Copyright © 2018 Сергей Пугач. All rights reserved.
//

import UIKit

struct User {
    
    var age: UInt?
    var name: String?
    var email: String?
    var password: String?
    
    init() {}
}

enum FieldType {
    
    case age//(WritableKeyPath<User, UInt?>)
    case name//(WritableKeyPath<User, String?>)
    case email//(WritableKeyPath<User, String?>)
    case password//(WritableKeyPath<User, String?>)
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .age: return .numberPad
        default: return .default
        }
    }
    
    var title: String {
        switch self {
        case .age: return "Age"
        case .name: return "Name"
        case .email: return "Email"
        case .password: return "Password"
        }
    }
}

//enum Test<T> {
//    case one, two
//    
//    var keyPath: WritableKeyPath<User, T> {
//        switch self {
//        case .one: return \User.age
//        case .two: return \User.email
//        }
//    }
//}
