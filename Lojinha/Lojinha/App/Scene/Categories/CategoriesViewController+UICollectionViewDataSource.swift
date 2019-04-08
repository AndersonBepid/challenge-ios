//
//  CategoriesViewController+UICollectionViewDataSource.swift
//  Lojinha
//
//  Created by Anderson Oliveira on 08/04/19.
//  Copyright © 2019 andersonOliveira. All rights reserved.
//

import UIKit

extension CategoriesViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.cellIdentifier, for: indexPath)
        guard let categoriesCell = cell as? CategoriesCollectionViewCell else {
            return CategoriesCollectionViewCell()
        }

        let category = categories[indexPath.row]
        categoriesCell.viewModel = category
        
        return categoriesCell
    }
}
