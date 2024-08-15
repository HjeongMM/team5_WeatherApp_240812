//
//  WeaterDetailCollectionViewCell.swift
//  WetherApp
//
//  Created by 유민우 on 8/13/24.
//

import UIKit
import SnapKit

final class WeaterDetailCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let id = "WeaterDetailCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    
    func configure(for item: Int) {
        // Cell 에 있는 기존의 서브 뷰 제거
        contentView.subviews.forEach { $0.removeFromSuperview() }
        contentView.backgroundColor = .green
        contentView.layer.cornerRadius = 15
        
        // 각 Cell 에 커스텀 뷰 추가
        switch item {
        case 0:
            let tempView = TempView()
            contentView.addSubview(tempView)
            tempView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        case 1:
            let feelingTempView = FeelingTempView()
            contentView.addSubview(feelingTempView)
            feelingTempView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        case 2:
            let humidityView = HumidityView()
            contentView.addSubview(humidityView)
            humidityView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        case 3:
            let weatherMessageView = WeatherMessageView()
            contentView.addSubview(weatherMessageView)
            weatherMessageView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        case 4:
            let rainView = RainView()
            contentView.addSubview(rainView)
            rainView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        case 5:
            let windView = WindView()
            contentView.addSubview(windView)
            windView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        default:
            break
        }
    }
    
}
