//
//  BestSellersViewController+UITableViewDataSource.swift
//  Lojinha
//
//  Created by Anderson Oliveira on 08/04/19.
//  Copyright © 2019 andersonOliveira. All rights reserved.
//

import UIKit

extension BestSellersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bestSellers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BestSellersTableViewCell.cellIdentifier, for: indexPath)
        guard let bestSellersCell = cell as? BestSellersTableViewCell else {
            return BestSellersTableViewCell()
        }
        
        let bestSell = bestSellers[indexPath.row]
        bestSellersCell.viewModel = bestSell
        
        return bestSellersCell
    }
}
