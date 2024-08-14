//
//  FillingTempView.swift
//  WetherApp
//
//  Created by 유민우 on 8/14/24.
//

// 상세날씨 페이지 CollectionViewCell 에 들어갈 '체감온도'contentView
import UIKit
import SnapKit

class FeelingTempView: UIView {
    
    // MARK: - Property
    
    // 테스트 뷰 나중에지울것
    let minwooView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 15
        return view
    }()
    
    // 타이틀
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "체감 온도"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    // 체감온도
    private let feelingTempLabel: UILabel = {
        let label = UILabel()
        label.text = "56°C"
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = .black
        label.textAlignment = .center
        return label
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
        // 테스트
        self.addSubview(minwooView)
        minwooView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(150)
            $0.width.equalTo(160)
        }
        
        [titleLabel, feelingTempLabel].forEach { minwooView.addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        feelingTempLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
        }
    }
}
