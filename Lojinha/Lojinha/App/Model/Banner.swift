//
//  Banner.swift
//  Lojinha
//
//  Created by Anderson Oliveira on 07/04/19.
//  Copyright © 2019 andersonOliveira. All rights reserved.
//

import Foundation

struct BannerResult: Codable {
    var data: [Banner]?
}

struct Banner: Codable {
    var id: Int
    var linkUrl: String?
    var urlImagem: String?
}
