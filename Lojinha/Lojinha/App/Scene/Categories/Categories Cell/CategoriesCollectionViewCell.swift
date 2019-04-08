//
//  CategoriesCollectionViewCell.swift
//  Lojinha
//
//  Created by Anderson Oliveira on 08/04/19.
//  Copyright © 2019 andersonOliveira. All rights reserved.
//

import UIKit
import Foundation

class CategoriesCollectionViewCell: UICollectionViewCell {

    static let cellIdentifier = "\(CategoriesCollectionViewCell.self)"
    
    var viewModel: ViewModel? {
        didSet {
            fill()
        }
    }

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    func fill() {
        guard let viewModel = viewModel, let urlString = viewModel.urlImage, let url = URL(string: urlString) else { return }
        productImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "categoryDefault"),
            options: [
                .cacheOriginalImage,
            ]
        )
        titleLabel.text = viewModel.title
    }
}

extension CategoriesCollectionViewCell {

    struct ViewModel {
        var urlImage: String?
        var title: String?
    }
}
