//
//  testView.swift
//  WetherApp
//
//  Created by 유민우 on 8/14/24.
//

import UIKit

class TestView: UIViewController {
    
    let testView = HumidityView()
    
    override func loadView() {
        view = testView
    }
    
}
