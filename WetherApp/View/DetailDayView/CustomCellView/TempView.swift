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
    
    let minwooView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 15
        return view
    }()
    
    // 최고 기온
    private let tempMAX: UILabel = {
        let label = UILabel()
        label.text = "최고: 88°C"
        label.font = .systemFont(ofSize: 25)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    // 최저 기온
    private let tempMin: UILabel = {
        let label = UILabel()
        label.text = "최저: 20°C"
        label.font = .systemFont(ofSize: 25)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    // 최고기온, 최저기온이 들어갈 스택뷰
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 2
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    // 날씨 아이콘이 들어갈 imageView
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "icon")
        return imageView
    }()
    
    // MARK: - LifeSycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    
    private func setupUI() {
        self.backgroundColor = .white
        self.addSubview(minwooView)
        
        [tempMAX, tempMin].forEach { stackView.addArrangedSubview($0) }
        
        tempMAX.snp.makeConstraints {
            $0.top.equalToSuperview().offset(25)
            $0.centerX.equalToSuperview()
        }
        
        tempMin.snp.makeConstraints {
            $0.top.equalTo(tempMAX.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
        
        [stackView, iconImageView].forEach { self.addSubview($0) }
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.width.equalTo(160)
        }
        
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.width.equalTo(160)
        }
    }
}
