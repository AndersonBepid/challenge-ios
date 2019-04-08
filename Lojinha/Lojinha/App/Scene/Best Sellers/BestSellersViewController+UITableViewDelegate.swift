//
//  BestSellersViewController+UITableViewDelegate.swift
//  Lojinha
//
//  Created by Anderson Oliveira on 08/04/19.
//  Copyright © 2019 andersonOliveira. All rights reserved.
//

import UIKit

extension BestSellersViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Mais Vendidos"
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125.0
    }
}
