//
//  File...swift
//  WetherApp
//
//  Created by 김동준 on 8/13/24.
//

import Foundation
import UIKit
import SnapKit

class WeatherTableViewCell: UITableViewCell {
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "요일" // Example text
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cloud.sun") // Example image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.text = "온도" // Example text
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(dayLabel)
        contentView.addSubview(weatherIcon)
        contentView.addSubview(tempLabel)
        
        dayLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(60)
        }
        
        weatherIcon.snp.makeConstraints {
            $0.leading.equalTo(dayLabel.snp.trailing).offset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        tempLabel.snp.makeConstraints {
            $0.leading.equalTo(weatherIcon.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


