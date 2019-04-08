//
//  UILabel+lineThrough.swift
//  Lojinha
//
//  Created by Anderson Oliveira on 08/04/19.
//  Copyright © 2019 andersonOliveira. All rights reserved.
//

import UIKit

extension UILabel {
    enum LineThroughType {
        case all
        case part(NSRange)
    }
    
    func lineThrough(in rangeType: LineThroughType = .all) {
        let test = NSMutableAttributedString(string: self.text ?? "")
        var range: NSRange!
        switch rangeType {
        case .all:
            range = NSRange(location: 0, length: test.length)
        case .part(let rangeValue):
            range = rangeValue
        }
        test.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: range)
        self.attributedText = test
    }
}
