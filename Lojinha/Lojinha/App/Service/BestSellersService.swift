//
//  BestSellersService.swift
//  Lojinha
//
//  Created by Anderson Oliveira on 08/04/19.
//  Copyright © 2019 andersonOliveira. All rights reserved.
//

import Moya
import Result

protocol BestSellersServiceDelegate {
    func getBestSellers(_ completion: @escaping (Result<[BestSellers]?, ServiceError>) -> Void)
}

class BestSellersService: BestSellersServiceDelegate {
    
    static let shared = BestSellersService()
    let provider = MoyaProvider<BestSellersTargetType>()
    var bestSellers: [BestSellers]?
    
    func getBestSellers(_ completion: @escaping (Result<[BestSellers]?, ServiceError>) -> Void) {
        provider.request(.getBestSellers()) { (result) in
            switch result {
            case .success(let moyaResponse):
                switch moyaResponse.statusCode {
                case 200..<300:
                    do {
                        let bestSellersResult = try JSONDecoder().decode(BestSellersResult.self, from: moyaResponse.data)
                        self.bestSellers = bestSellersResult.data
                        completion(.success(bestSellersResult.data))
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
