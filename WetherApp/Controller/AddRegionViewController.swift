//
//  AddRegionViewController.swift
//  WetherApp
//
//  Created by t2023-m0112 on 8/19/24.
//

import UIKit

class AddRegionViewController: UIViewController {

    var weatherData: CurrentWeatherResult?  // 날씨 데이터
    var locationName: String?  // 지역 이름을 저장하는 속성
    
    private let addRegionView = AddRegionView()
    
    override func loadView() {
        view = addRegionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainDarkGray
        
        // weatherData와 locationName이 설정되었을 경우, 해당 데이터를 이용해 UI 업데이트
        if let weatherData = weatherData, let locationName = locationName {
            configure(with: weatherData, locationName: locationName)
        }
    }
    
    func configure(with weatherData: CurrentWeatherResult, locationName: String) {
        addRegionView.updateLocationLabel(locationName)
        
        // WeatherDataFormatter를 사용하여 날씨 상태와 아이콘을 가져옴
        let weatherStatus = WeatherDataFormatter.shared.translateWeatherCondition(weatherData.weather.first?.main ?? "알 수 없음")
        let iconName = WeatherDataFormatter.shared.iconWeatherCondition(weatherData.weather.first?.main ?? "")
        
        addRegionView.updateWeatherStatus(weatherStatus)
        addRegionView.updateWeatherIcon(iconName)
        
        // 기온 정보 업데이트
        let currentTemp = Int(weatherData.main.temp)
        let minTemp = Int(weatherData.main.temp_min)
        let maxTemp = Int(weatherData.main.temp_max)
        addRegionView.updateTemperature(current: currentTemp, min: minTemp, max: maxTemp)
    }
}
