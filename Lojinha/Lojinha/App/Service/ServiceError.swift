//
//  ServiceError.swift
//  Lojinha
//
//  Created by Anderson Oliveira on 08/04/19.
//  Copyright © 2019 andersonOliveira. All rights reserved.
//

import Moya
import Result

public struct BusinessError: Codable, Error {
    var statusCode: Int?
    var code: String?
    var text: String?
    var title: String?
}

public enum ServiceError: Swift.Error {
    case businessError(BusinessError)
    case moyaError(MoyaError)
}
