//
//  BestSellersTableViewCell.swift
//  Lojinha
//
//  Created by Anderson Oliveira on 08/04/19.
//  Copyright © 2019 andersonOliveira. All rights reserved.
//

import UIKit

class BestSellersTableViewCell: UITableViewCell {

    static let cellIdentifier = "\(BestSellersTableViewCell.self)"

    var viewModel: ViewModel? {
        didSet {
            fill()
        }
    }
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var currentPriceLabel: UILabel!

    func fill() {
        guard let viewModel = viewModel, let urlString = viewModel.urlImage, let url = URL(string: urlString) else { return }
        productImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .cacheOriginalImage
            ]
        )
        titleLabel.text = viewModel.title
        oldPriceLabel.text = viewModel.oldPrice
        currentPriceLabel.text = viewModel.currentPrice
    }
}

extension BestSellersTableViewCell {

    struct ViewModel {
        var urlImage: String?
        var title: String?
        var oldPrice: String?
        var currentPrice: String?
    }
}
