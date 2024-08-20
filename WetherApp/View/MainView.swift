//
//  MainView.swift
//  WetherApp
//
//  Created by 임혜정 on 8/16/24.
//

import UIKit
import SnapKit

class MainView: UIView {
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    let locationLabel: UILabel = {
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
        imageView.tintColor = .mainGreen
        return imageView
    }()
    
    private let weatherStatusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainGreen
        label.font = .systemFont(ofSize: 28)
        label.textAlignment = .center
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .mainGreen
        label.font = UIFont.systemFont(ofSize: 32, weight: .medium)
        return label
    }()
    
    private let minMaxStackview: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.text = "최저 최고"
        label.textAlignment = .center
        label.textColor = .mainGreen
        label.font = .systemFont(ofSize: 16)
        return label
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 60, height: 100)
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .mainDarkGray
        collectionView.register(ThreeHourlyCollectionViewCell.self, forCellWithReuseIdentifier: "ThreeHourlyCollectionViewCell")
        return collectionView
    }()
    
    func addBordersToCollectionView() {
        let backgroundView = UIView(frame: collectionView.bounds)
        backgroundView.backgroundColor = .clear
        let topBorder = UIView(frame: CGRect(x: 0, y: 0, width: backgroundView.frame.width, height: 1))
        topBorder.backgroundColor = .mainGreen
        let bottomBorder = UIView(frame: CGRect(x: 0, y: backgroundView.frame.height - 1, width: backgroundView.frame.width, height: 1))
        bottomBorder.backgroundColor = .mainGreen
        backgroundView.addSubview(topBorder)
        backgroundView.addSubview(bottomBorder)
        collectionView.contentInset = .zero
        collectionView.backgroundView = backgroundView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCurrentWeatherLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: "WeatherTableViewCell")
        return tableView
    }()
    
    
    // MARK: - Auto Layout
    
    private func setupCurrentWeatherLayout() {
        [mainStackView, collectionView, tableView].forEach {
            self.addSubview($0)
        }
        
        mainStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(340)
            $0.height.equalTo(300)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(mainStackView.snp.bottom).offset(25)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(340)
            $0.height.equalTo(135)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(340)
            $0.height.equalTo(250)
        }
        
        setupMainStackView()
    }
    
    private func setupMainStackView() {
        [locationLabel, weatherIcon, weatherStatusLabel, tempLabel, minMaxStackview].forEach {
            self.addSubview($0)
        }

        locationLabel.snp.makeConstraints {
            $0.top.equalTo(mainStackView.snp.top).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        weatherIcon.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom).offset(20)
            $0.width.height.equalTo(100)
            $0.centerX.equalToSuperview()
        }
        
        weatherStatusLabel.snp.makeConstraints {
            $0.top.equalTo(weatherIcon.snp.bottom).offset(16)
            $0.width.equalTo(120)
            $0.height.equalTo(30)
            $0.centerX.equalToSuperview()
        }
        
        tempLabel.snp.makeConstraints {
            $0.top.equalTo(weatherStatusLabel.snp.bottom).offset(10)
            $0.width.equalTo(200)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
        }
        
        minMaxStackview.snp.makeConstraints {
            $0.top.equalTo(tempLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(180)
            $0.height.equalTo(30)
        }
        
        setupMinMaxStackView()
    }
    
    private func setupMinMaxStackView() {
        addTempLabel()
    }
    
    private func addTempLabel() {
        (1...2).forEach { label in
            let label = createLabel()
            minMaxStackview.addArrangedSubview(label)
        }
    }
    
    func updateLocationLabel(_ locationName: String) {
        locationLabel.text = locationName
    }
    
    func updateWeatherStatus(_ status: String) {
        weatherStatusLabel.text = status
    }
    
    func updateWeatherIcon(_ iconName: String) {
        weatherIcon.image = UIImage(systemName: iconName)
    }
    
    func updateWeatherUI(with data: (description: String, temp: Int, minTemp: Int, maxTemp: Int)) {
        weatherStatusLabel.text = "\(data.description)"
        tempLabel.text = " 현재 \(data.temp)°C"
        if let minTempLabel = minMaxStackview.arrangedSubviews[0] as? UILabel,
           let maxTempLabel = minMaxStackview.arrangedSubviews[1] as? UILabel {
            minTempLabel.text = "최저: \(data.minTemp)°C   /"
            maxTempLabel.text = "최고: \(data.maxTemp)°C"
        }
    }
}


