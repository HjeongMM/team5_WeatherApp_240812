//
//  RainView.swift
//  WetherApp
//
//  Created by 유민우 on 8/15/24.
//

// 상세날씨 페이지 CollectionViewCell 에 들어갈 '강수량'contentView
import UIKit
import SnapKit

class RainView: UIView {
    
    // MARK: - Property
    
    // 강수량
    private let rainLabel: UILabel = {
        let label = UILabel()
        label.text = "강수량: 1mm"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    // 강수확률
    private let popLabel: UILabel = {
        let label = UILabel()
        label.text = "강수확률: 0.07%"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    // 강수량, 강수확률이 들어갈 스택뷰
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    
    private func setupUI() {
        self.backgroundColor = .clear
        
        [rainLabel, popLabel].forEach { stackView.addArrangedSubview($0) }
        
        rainLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
            $0.height.equalTo(20)
        }
        
        popLabel.snp.makeConstraints {
            $0.top.equalTo(rainLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
            $0.height.equalTo(20)
        }
        
        self.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
