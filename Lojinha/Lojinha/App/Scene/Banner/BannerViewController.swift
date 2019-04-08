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

    var banners: [BannerCollectionViewCell.ViewModel] = []
    lazy var presenter = BannerPresenter(delegate: self)
    var numberPages: Int = 0 {
        didSet {
            pageControl.numberOfPages = numberPages
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setupStyle()
        presenter.loadData()
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

extension BannerViewController: BannerPresenterDelegate {

    func bannerPresenter(didLoadViewModel viewModel: BannerPresenter.ViewModel) {
        banners = viewModel.cellViewModels ?? []
        pageControl.numberOfPages = banners.count
        collectionView.reloadData()
    }

    func bannerPresenter(didReceiveError errorMessege: String) {
        let alertController = UIAlertController(title: "Houston, i have a problem...", message: errorMessege, preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "Ok, entendi", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
