//
//  ListCollectionViewCell.swift
//  WetherApp
//
//  Created by t2023-m0112 on 8/12/24.
//

import UIKit
import SnapKit

class ListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Elements
    
    let blueSquareView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Setup Methods
    
    private func setupView() {
        contentView.addSubview(blueSquareView)
        
        blueSquareView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(0) 
        }
    }
}

