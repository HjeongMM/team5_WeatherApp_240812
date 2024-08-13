//
//  ListViewController.swift
//  WetherApp
//
//  Created by t2023-m0112 on 8/12/24.
//

import UIKit

class ListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listView = ListView()
        view.addSubview(listView)
        
        listView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
    }
}

