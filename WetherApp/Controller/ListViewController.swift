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
        
        // ListView 인스턴스 생성
        let listView = ListView()
        view.addSubview(listView)
        
        // SnapKit을 사용하여 ListView의 레이아웃 설정
        listView.snp.makeConstraints {
            $0.edges.equalTo(view) // ListView가 화면 전체를 채우도록 설정
        }
    }
}

