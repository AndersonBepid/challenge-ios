//
//  CategoryTargetType.swift
//  Lojinha
//
//  Created by Anderson Oliveira on 08/04/19.
//  Copyright © 2019 andersonOliveira. All rights reserved.
//

import Moya
import Result

enum CategoryTargetType {
    case getCategory()
}

extension CategoryTargetType: TargetType {
    var baseURL: URL {
        return URL(string: "https://alodjinha.herokuapp.com")!
    }
    
    var path: String {
        switch self {
        case .getCategory():
            return "/categoria"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCategory():
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getCategory():
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getCategory():
            return nil
        }
    }
}
