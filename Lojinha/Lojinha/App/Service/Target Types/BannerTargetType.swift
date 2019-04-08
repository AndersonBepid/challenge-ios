//
//  BannerTargetType.swift
//  Lojinha
//
//  Created by Anderson Oliveira on 07/04/19.
//  Copyright © 2019 andersonOliveira. All rights reserved.
//

import Moya
import Result

enum BannerTargetType {
    case getBanner()
}

extension BannerTargetType: TargetType {
    var baseURL: URL {
        return URL(string: "https://alodjinha.herokuapp.com")!
    }
    
    var path: String {
        switch self {
        case .getBanner():
            return "/banner"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getBanner():
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getBanner():
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getBanner():
            return nil
        }
    }
}
