//
//  File.swift
//  WetherApp
//
//  Created by 김동준 on 8/13/24.
//

import UIKit
import SnapKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    let timeButton: UIButton = {
        let button = UIButton()
        button.setTitle("시간", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    let weatherButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "sun.max"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    let tempButton: UIButton = {
        let button = UIButton()
        button.setTitle("온도", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(timeButton)
        contentView.addSubview(weatherButton)
        contentView.addSubview(tempButton)
        
        timeButton.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        
        weatherButton.snp.makeConstraints { make in
            make.top.equalTo(timeButton.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        tempButton.snp.makeConstraints { make in
            make.top.equalTo(weatherButton.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        timeButton.addTarget(self, action: #selector(timeButtonTapped), for: .touchUpInside)
        weatherButton.addTarget(self, action: #selector(weatherButtonTapped), for: .touchUpInside)
        tempButton.addTarget(self, action: #selector(tempButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Button actions
    @objc private func timeButtonTapped() {
        print("Time button tapped")
    }
    
    @objc private func weatherButtonTapped() {
        print("Weather button tapped")
    }
    
    @objc private func tempButtonTapped() {
        print("Temperature button tapped")
    }
}

