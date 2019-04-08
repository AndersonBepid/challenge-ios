//
//  CategoryService.swift
//  Lojinha
//
//  Created by Anderson Oliveira on 08/04/19.
//  Copyright © 2019 andersonOliveira. All rights reserved.
//

import Moya
import Result

protocol CategoryServiceDelegate {
    func getCategory(_ completion: @escaping (Result<[Category]?, ServiceError>) -> Void)
}

class CategoryService: CategoryServiceDelegate {
    
    static let shared = CategoryService()
    let provider = MoyaProvider<CategoryTargetType>()
    var categories: [Category]?
    
    func getCategory(_ completion: @escaping (Result<[Category]?, ServiceError>) -> Void) {
        provider.request(.getCategory()) { (result) in
            switch result {
            case .success(let moyaResponse):
                switch moyaResponse.statusCode {
                case 200..<300:
                    do {
                        let categoryResult = try JSONDecoder().decode(CategoryResult.self, from: moyaResponse.data)
                        self.categories = categoryResult.data
                        completion(.success(categoryResult.data))
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
