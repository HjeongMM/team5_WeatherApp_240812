//
//  LocationModel.swift
//  WetherApp
//
//  Created by t2023-m0112 on 8/19/24.
//

import Foundation

// 위치 검색 결과를 위한 구조체
struct LocationResult: Codable {
    let name: String
    let country: String
    let lat: Double
    let lon: Double
}

// API에서 오류가 발생했을 때 처리하기 위한 구조체
struct ErrorResponse: Codable {
    let message: String
}

