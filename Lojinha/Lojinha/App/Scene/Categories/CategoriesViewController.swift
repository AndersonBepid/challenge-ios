//
//  CategoriesViewController.swift
//  Lojinha
//
//  Created by Anderson Oliveira on 08/04/19.
//  Copyright © 2019 andersonOliveira. All rights reserved.
//

import UIKit
import Foundation

class CategoriesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var categories: [CategoriesCollectionViewCell.ViewModel] = []
    lazy var presenter = CategoriesPresenter(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setupStyle()
        presenter.loadData()
    }

    private func setupStyle() {
        collectionView.backgroundColor = .clear
    }

    private func registerCell() {
        let categoriesNib = UINib(nibName: CategoriesCollectionViewCell.cellIdentifier, bundle: nil)
        collectionView.register(categoriesNib, forCellWithReuseIdentifier: CategoriesCollectionViewCell.cellIdentifier)
    }
}

extension CategoriesViewController: CategoriesPresenterDelegate {

    func categoriesPresenter(didLoadViewModel viewModel: CategoriesPresenter.ViewModel) {
        categories = viewModel.cellViewModels ?? []
        collectionView.reloadData()
    }

    func categoriesPresenter(didReceiveError errorMessege: String) {
        let alertController = UIAlertController(title: "Houston, i have a problem...", message: errorMessege, preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "Ok, entendi", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
