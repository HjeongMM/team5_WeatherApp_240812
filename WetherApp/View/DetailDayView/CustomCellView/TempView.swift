//
//  TempView.swift
//  WetherApp
//
//  Created by 유민우 on 8/14/24.
//


// 상세날씨 페이지에 CollectionViewCell 에 들어갈 contentView

import UIKit
import SnapKit

class TempView: UIView {
    
    // MARK: - Property
    
    // 최고 기온
    private let tempMAX: UILabel = {
        let label = UILabel()
        label.text = "최고: 88°C"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    // 최저 기온
    private let tempMin: UILabel = {
        let label = UILabel()
        label.text = "최저: -20°C"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    // 최고기온, 최저기온이 들어갈 스택뷰
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    // 날씨 아이콘이 들어갈 imageView
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
}
