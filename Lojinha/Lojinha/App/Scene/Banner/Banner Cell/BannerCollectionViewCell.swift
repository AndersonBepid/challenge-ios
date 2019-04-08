//
//  BannerCollectionViewCell.swift
//  Lojinha
//
//  Created by Anderson Oliveira on 07/04/19.
//  Copyright © 2019 andersonOliveira. All rights reserved.
//

import UIKit
import Kingfisher

class BannerCollectionViewCell: UICollectionViewCell {

    static let cellIdentifier = "\(BannerCollectionViewCell.self)"

    @IBOutlet weak var imageView: UIImageView!

    var viewModel: ViewModel? {
        didSet {
            fill()
        }
    }

    private func fill() {
        guard let viewModel = viewModel, let urlString = viewModel.urlImage, let url = URL(string: urlString) else { return }
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
            .cacheOriginalImage
            ]
        )
    }
}

extension BannerCollectionViewCell {

    struct ViewModel {
        let urlImage: String?
    }
}
