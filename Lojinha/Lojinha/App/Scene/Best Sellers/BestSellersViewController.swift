//
//  BestSellersViewController.swift
//  Lojinha
//
//  Created by Anderson Oliveira on 08/04/19.
//  Copyright © 2019 andersonOliveira. All rights reserved.
//

import UIKit

class BestSellersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var bestSellers: [BestSellersTableViewCell.ViewModel] = []
    lazy var presenter = BestSellersPresenter(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        presenter.loadData()
    }
    
    private func registerCell() {
        let bestSellersNib = UINib(nibName: BestSellersTableViewCell.cellIdentifier, bundle: nil)
        tableView.register(bestSellersNib, forCellReuseIdentifier: BestSellersTableViewCell.cellIdentifier)
    }
}

extension BestSellersViewController: BestSellersPresenterDelegate {

    func bestSellersPresenter(didLoadViewModel viewModel: BestSellersPresenter.ViewModel) {
        bestSellers = viewModel.cellViewModels ?? []
        tableView.reloadData()
    }

    func bestSellersPresenter(didReceiveError errorMessege: String) {
        let alertController = UIAlertController(title: "Houston, i have a problem...", message: errorMessege, preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "Ok, entendi", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
