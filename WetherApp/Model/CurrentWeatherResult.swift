//
//  CurrentWeatherResult.swift
//  WetherApp
//
//  Created by 이진규 on 8/13/24.
//

import Foundation


// CurrentWeatherResult와 ForecastWeatherResult 모델 정의
struct CurrentWeatherResult: Codable {
    let weather: [Weather] // 날씨 정보 배열
    let main: WeatherMain // 주요 날씨 정보 (온도, 습도 등)
}

struct Weather: Codable {
    let id: Int // 날씨 ID
    let main: String // 날씨 상태 (예: "Clear")
    let description: String // 날씨 설명 (예: "clear sky")
    let icon: String // 날씨 아이콘의 파일명
}

struct WeatherMain: Codable {
    let temp: Double // 현재 온도
    let temp_min: Double // 최저 온도
    let temp_max: Double // 최고 온도
    let humidity: Int // 습도
}

struct ForecastWeatherResult: Codable {
    let list: [ForecastWeather] // 날씨 예보 리스트
}

struct ForecastWeather: Codable {
    let main: WeatherMain // 주요 날씨 정보 (온도, 습도 등)
    let weather: [Weather]
    let dtTxt: String // 날짜와 시간 정보

    enum CodingKeys: String, CodingKey { //
        case main // JSON 키와 구조체 키의 매핑
        case weather
        case dtTxt = "dt_txt" // JSON에서 "dt_txt" 키를 "dtTxt" 변수와 매핑
    }
}

