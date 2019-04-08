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

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    
    private func registerCell() {
        let bestSellersNib = UINib(nibName: BestSellersTableViewCell.cellIdentifier, bundle: nil)
        tableView.register(bestSellersNib, forCellReuseIdentifier: BestSellersTableViewCell.cellIdentifier)
    }
}
