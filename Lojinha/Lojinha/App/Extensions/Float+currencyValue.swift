//
//  Float+currencyValue.swift
//  Lojinha
//
//  Created by Anderson Oliveira on 08/04/19.
//  Copyright © 2019 andersonOliveira. All rights reserved.
//

import Foundation

extension Float {
    var currencyValue: String {
        get {
            let number: NSNumber! = NSNumber(value: self)
            let formatter = NumberFormatter()
            formatter.usesGroupingSeparator = true
            formatter.numberStyle = .currencyAccounting
            formatter.currencyCode = "BRL"
            formatter.locale = Locale(identifier: "pt_BR")
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 2
            return formatter.string(from: number)!
        }
    }
}
