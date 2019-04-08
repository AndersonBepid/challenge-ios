//
//  CategoriesPresenter.swift
//  Lojinha
//
//  Created by Anderson Oliveira on 08/04/19.
//  Copyright © 2019 andersonOliveira. All rights reserved.
//

import UIKit
import Foundation

protocol CategoriesPresenterDelegate: class {
    func categoriesPresenter(didLoadViewModel viewModel: CategoriesPresenter.ViewModel)
    func categoriesPresenter(didReceiveError errorMessege: String)
}

class CategoriesPresenter {
    
    public weak var delegate: CategoriesPresenterDelegate?
    let categoryService: CategoryServiceDelegate
    private(set) var viewModel: CategoriesPresenter.ViewModel
    
    init(delegate: CategoriesPresenterDelegate, categoryService: CategoryServiceDelegate = CategoryService.shared) {
        self.delegate = delegate
        self.categoryService = categoryService
        self.viewModel = ViewModel(cellViewModels: nil, serviceError: nil)
    }
    
    func loadData() {
        categoryService.getCategory { (result) in
            switch result {
            case .success(let categories):
                self.viewModel.cellViewModels = self.cellViewModels(by: categories)
                self.delegate?.categoriesPresenter(didLoadViewModel: self.viewModel)
            case .failure(let error):
                self.delegate?.categoriesPresenter(didReceiveError: error.localizedDescription)
            }
        }
    }
    
    private func cellViewModels(by categories: [Category]?) -> [CategoriesCollectionViewCell.ViewModel]? {
        guard let categories = categories else { return nil }
        return categories.map {
            CategoriesCollectionViewCell.ViewModel(urlImage: $0.urlImagem, title: $0.descricao)
        }
    }
}

extension CategoriesPresenter {
    
    struct ViewModel {
        var cellViewModels: [CategoriesCollectionViewCell.ViewModel]?
        var serviceError: ServiceError?
    }
}
