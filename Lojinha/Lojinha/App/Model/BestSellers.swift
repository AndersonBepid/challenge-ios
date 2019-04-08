//
//  BestSellers.swift
//  Lojinha
//
//  Created by Anderson Oliveira on 08/04/19.
//  Copyright © 2019 andersonOliveira. All rights reserved.
//

import Foundation

struct BestSellersResult: Codable {
    var data: [BestSellers]?
}

struct BestSellers: Codable {
    var id: Int
    var categoria: Category?
    var descricao: String?
    var name: String?
    var oldPrice: Float?
    var currentPrice: Float?
    var urlImagem: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "nome"
        case oldPrice = "precoDe"
        case currentPrice = "precoPor"
        case urlImagem = "urlImagem"
    }
}
