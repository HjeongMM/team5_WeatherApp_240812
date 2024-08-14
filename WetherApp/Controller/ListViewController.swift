//
//  ListViewController.swift
//  WetherApp
//
//  Created by t2023-m0112 on 8/12/24.
//

import UIKit

final class ListViewController: UIViewController {
    let listView = ListView()
    
    override func loadView() {
        view = listView
    }
}

