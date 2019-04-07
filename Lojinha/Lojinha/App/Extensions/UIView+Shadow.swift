//
//  UIView+Shadow.swift
//  Lojinha
//
//  Created by Anderson Oliveira on 07/04/19.
//  Copyright © 2019 andersonOliveira. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func dropShadow(color: UIColor = .black, opacity: Float = 1.0, offSet: CGSize = CGSize(width: 0, height: 0), radius: CGFloat = 3.0) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
    }
}
