//
//  BestSellersPresenter.swift
//  Lojinha
//
//  Created by Anderson Oliveira on 08/04/19.
//  Copyright © 2019 andersonOliveira. All rights reserved.
//

import UIKit
import Foundation

protocol BestSellersPresenterDelegate: class {
    func bestSellersPresenter(didLoadViewModel viewModel: BestSellersPresenter.ViewModel)
    func bestSellersPresenter(didReceiveError errorMessege: String)
}

class BestSellersPresenter {
    
    public weak var delegate: BestSellersPresenterDelegate?
    let bestSellersService: BestSellersServiceDelegate
    private(set) var viewModel: BestSellersPresenter.ViewModel
    
    init(delegate: BestSellersPresenterDelegate, bestSellersService: BestSellersServiceDelegate = BestSellersService.shared) {
        self.delegate = delegate
        self.bestSellersService = bestSellersService
        self.viewModel = ViewModel(cellViewModels: nil, serviceError: nil)
    }
    
    func loadData() {
        bestSellersService.getBestSellers { (result) in
            switch result {
            case .success(let bestSellers):
                self.viewModel.cellViewModels = self.cellViewModels(by: bestSellers)
                self.delegate?.bestSellersPresenter(didLoadViewModel: self.viewModel)
            case .failure(let error):
                self.delegate?.bestSellersPresenter(didReceiveError: error.localizedDescription)
            }
        }
    }
    
    private func cellViewModels(by bestSellers: [Product]?) -> [BestSellersTableViewCell.ViewModel]? {
        guard let bestSellers = bestSellers else { return nil }
        return bestSellers.map {
            BestSellersTableViewCell.ViewModel(urlImage: $0.urlImagem, title: $0.name, oldPrice: "\($0.oldPrice?.currencyValue ?? "")", currentPrice: "\($0.currentPrice?.currencyValue ?? "")")
        }
    }
}

extension BestSellersPresenter {
    
    struct ViewModel {
        var cellViewModels: [BestSellersTableViewCell.ViewModel]?
        var serviceError: ServiceError?
    }
}
