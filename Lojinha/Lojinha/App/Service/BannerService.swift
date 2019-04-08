//
//  BannerService.swift
//  Lojinha
//
//  Created by Anderson Oliveira on 07/04/19.
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

protocol BannerServiceDelegate {
    func getBanner(_ completion: @escaping (Result<[Banner]?, ServiceError>) -> Void)
}

class BannerService: BannerServiceDelegate {
    
    static let shared = BannerService()
    let provider = MoyaProvider<BannerTargetType>()
    var banners: [Banner]?

    func getBanner(_ completion: @escaping (Result<[Banner]?, ServiceError>) -> Void) {
        provider.request(.getBanner()) { (result) in
            switch result {
            case .success(let moyaResponse):
                switch moyaResponse.statusCode {
                case 200..<300:
                    do {
                        let bannerResult = try JSONDecoder().decode(BannerResult.self, from: moyaResponse.data)
                        self.banners = bannerResult.data
                        completion(.success(bannerResult.data))
                    } catch {
                        completion(.failure(ServiceError.moyaError(MoyaError.jsonMapping(moyaResponse))))
                    }
                default:
                    completion(.failure(ServiceError.moyaError(MoyaError.jsonMapping(moyaResponse))))
                }
            case .failure(let error):
                completion(.failure(ServiceError.moyaError(error)))
            }
        }
    }
}
