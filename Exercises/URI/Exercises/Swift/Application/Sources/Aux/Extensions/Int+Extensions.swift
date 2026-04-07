//
//  Int+Extensions.swift
//  UriExercicios
//
//  Created by Gui Reis on 23/04/24.
//

import Foundation


extension Int {
    
    var isZero: Bool {
        self == 0
    }
    
    func isDivisible(by num: Int) -> Bool {
        self % num == 0
    }
    
    func isBigger(then num: Int) -> Bool {
        self > num
    }
    
    func isLower(then num: Int) -> Bool {
        self < num
    }
}

// 0.isBigger(then: 2)
