//
//  BestSellersTargetType.swift
//  Lojinha
//
//  Created by Anderson Oliveira on 08/04/19.
//  Copyright © 2019 andersonOliveira. All rights reserved.
//

import Moya
import Result

enum BestSellersTargetType {
    case getBestSellers()
}

extension BestSellersTargetType: TargetType {
    var baseURL: URL {
        return URL(string: "https://alodjinha.herokuapp.com/produto")!
    }
    
    var path: String {
        switch self {
        case .getBestSellers():
            return "/maisvendidos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getBestSellers():
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getBestSellers():
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getBestSellers():
            return nil
        }
    }
}
