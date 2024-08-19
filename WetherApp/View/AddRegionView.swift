//
//  AddRegionView.swift
//  WetherApp
//
//  Created by t2023-m0112 on 8/19/24.
//

import UIKit
import SnapKit

class AddRegionView: UIView {

    // UI Components
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "(검색된) 위치"
        label.textColor = .mainGreen
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    private let weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .mainGreen  // SF 심볼 색상을 mainGreen으로 설정
        return imageView
    }()
    
    private let weatherStatusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainGreen
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28)
        return label
    }()
    
    private let currentTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainGreen
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 32, weight: .medium)
        return label
    }()
    
    private let minMaxTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainGreen
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    // Initialize View
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewLayout() {
        addSubview(locationLabel)
        addSubview(weatherIcon)
        addSubview(weatherStatusLabel)
        addSubview(currentTempLabel)
        addSubview(minMaxTempLabel)
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)  // 화면 맨 위에 위치
            make.centerX.equalToSuperview()
        }
        
        weatherIcon.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(20)  // 지역명 아래에 위치
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)  // 아이콘 크기 설정
        }
        
        weatherStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherIcon.snp.bottom).offset(16)  // 심볼 아래에 날씨 상태 위치
            make.centerX.equalToSuperview()
        }
        
        currentTempLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherStatusLabel.snp.bottom).offset(16)  // 현재 기온 위치
            make.centerX.equalToSuperview()
        }
        
        minMaxTempLabel.snp.makeConstraints { make in
            make.top.equalTo(currentTempLabel.snp.bottom).offset(16)  // 최저, 최고 기온 위치
            make.centerX.equalToSuperview()
        }
    }
    
    // Functions to update the UI
    func updateLocationLabel(_ locationName: String) {
        locationLabel.text = locationName
    }
    
    func updateWeatherIcon(_ iconName: String) {
        weatherIcon.image = UIImage(systemName: iconName)
    }
    
    func updateWeatherStatus(_ status: String) {
        weatherStatusLabel.text = status
    }
    
    func updateTemperature(current: Int, min: Int, max: Int) {
        currentTempLabel.text = "현재 \(current)°C"
        minMaxTempLabel.text = "최저 \(min)°C   /   최고 \(max)°C"
    }
}
