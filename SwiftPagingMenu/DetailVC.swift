//
//  DetailVC.swift
//  SwiftPagingMenu
//
//  Created by Ekramul Hoque on 13/11/19.
//  Copyright © 2019 Ekramul Hoque. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.blue.withAlphaComponent(0.0)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
       self.navigationController!.navigationBar.isTranslucent = false
    }

  
}
