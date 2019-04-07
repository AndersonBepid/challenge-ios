//
//  BannerViewController.swift
//  Lojinha
//
//  Created by Anderson Oliveira on 07/04/19.
//  Copyright © 2019 andersonOliveira. All rights reserved.
//

import UIKit

class BannerViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setupStyle()
        
        pageControl.numberOfPages = collectionView.numberOfItems(inSection: 0)
    }

    private func setupStyle() {
        collectionView.collectionViewLayout = SnapPagingLayout() { (currentPage) in
            self.pageControl.currentPage = currentPage
        }
        collectionView.backgroundColor = .clear
        pageControl.dropShadow()
    }

    private func registerCell() {
        let bannerNib = UINib(nibName: BannerCollectionViewCell.cellIdentifier, bundle: nil)
        collectionView.register(bannerNib, forCellWithReuseIdentifier: BannerCollectionViewCell.cellIdentifier)
    }
}
