//
//  BannerPresenter.swift
//  Lojinha
//
//  Created by Anderson Oliveira on 07/04/19.
//  Copyright © 2019 andersonOliveira. All rights reserved.
//

import UIKit
import Foundation

protocol BannerPresenterDelegate: class {
    func bannerPresenter(didLoadViewModel viewModel: BannerPresenter.ViewModel)
    func bannerPresenter(didReceiveError errorMessege: String)
}

class BannerPresenter {
    
    public weak var delegate: BannerPresenterDelegate?
    let bannerService: BannerServiceDelegate
    private(set) var viewModel: BannerPresenter.ViewModel
    
    init(delegate: BannerPresenterDelegate, bannerService: BannerServiceDelegate = BannerService.shared) {
        self.delegate = delegate
        self.bannerService = bannerService
        self.viewModel = ViewModel(cellViewModels: nil, serviceError: nil)
    }
    
    func loadData() {
        bannerService.getBanner { (result) in
            switch result {
            case .success(let banners):
                self.viewModel.cellViewModels = self.cellViewModels(by: banners)
                self.delegate?.bannerPresenter(didLoadViewModel: self.viewModel)
            case .failure(let error):
                self.delegate?.bannerPresenter(didReceiveError: error.localizedDescription)
            }
        }
    }

    func openUrl(by index: Int) {
        guard let banner = BannerService.shared.banners?[index],
            let urlString = banner.linkUrl,
            let url = URL(string: urlString)
        else { return }

        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    private func cellViewModels(by banners: [Banner]?) -> [BannerCollectionViewCell.ViewModel]? {
        guard let banners = banners else { return nil }
        return banners.map {
            BannerCollectionViewCell.ViewModel(urlImage: $0.urlImagem)
        }
    }
}

extension BannerPresenter {

    struct ViewModel {
        var cellViewModels: [BannerCollectionViewCell.ViewModel]?
        var serviceError: ServiceError?
    }
}
