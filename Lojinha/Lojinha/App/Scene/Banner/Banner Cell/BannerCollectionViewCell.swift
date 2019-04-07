//
//  BannerCollectionViewCell.swift
//  Lojinha
//
//  Created by Anderson Oliveira on 07/04/19.
//  Copyright © 2019 andersonOliveira. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {

    static let cellIdentifier = "\(BannerCollectionViewCell.self)"

    @IBOutlet weak var imageView: UIImageView!

    var viewModel: ViewModel? {
        didSet {
            fill()
        }
    }

    private func fill() {
        guard let viewModel = viewModel else { return }
        imageView.image = viewModel.image
    }
}

extension BannerCollectionViewCell {

    struct ViewModel {
        let image: UIImage?
    }
}
