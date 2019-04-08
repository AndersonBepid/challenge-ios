//
//  BannerViewController+UICollectionViewDataSource.swift
//  Lojinha
//
//  Created by Anderson Oliveira on 07/04/19.
//  Copyright © 2019 andersonOliveira. All rights reserved.
//

import UIKit

extension BannerViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.cellIdentifier, for: indexPath)
        guard let bannerCell = cell as? BannerCollectionViewCell else {
            return BannerCollectionViewCell()
        }
        
        let banner = banners[indexPath.item]
        bannerCell.viewModel = banner
        
        return bannerCell
    }
}
