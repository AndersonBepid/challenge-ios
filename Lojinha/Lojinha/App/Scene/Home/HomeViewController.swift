//
//  HomeViewController.swift
//  Lojinha
//
//  Created by Anderson Oliveira on 07/04/19.
//  Copyright © 2019 andersonOliveira. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var bannerContainerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
    }
    
    private func setupStyle() {
        bannerContainerView.dropShadow()
        if let titleView = navigationController?.view, let navBar = navigationController?.navigationBar {
            let logoNavbarAsset = UIImage(named: UIImage.AssetName.logoNavbar.rawValue)
            let logoNavbarImageView = UIImageView(image: logoNavbarAsset)
            logoNavbarImageView.contentMode = .scaleAspectFit
            logoNavbarImageView.frame = navBar.frame
            logoNavbarImageView.frame.size.height -= 8
            titleView.addSubview(logoNavbarImageView)
        }
    }
}
