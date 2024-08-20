//
//  AddRegionViewController.swift
//  WetherApp
//
//  Created by t2023-m0112 on 8/19/24.
//

import UIKit
import CoreLocation

class AddRegionViewController: MainViewController {
    private let listView = ListView()
    var currentWeather: CurrentWeatherResult?
    var locationName: String?
    private var coordinate: CLLocationCoordinate2D?
    
    private var addRegionView: MainView {
        return view as! MainView
    }
    override func loadView() {
        super.loadView()
        (view as? MainView)?.addAddButton()
        (view as? MainView)?.addCancelButton()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCancelAddButton()
        updateUI()
        if let coordinate = coordinate {
            fetchWeatherData(for: coordinate)
        }
    }

    private func setupCancelAddButton() {
        addRegionView.addButton?.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addRegionView.cancelButton?.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }

    private func updateUI() {
        if let locationName = locationName {
            addRegionView.updateLocationLabel(locationName)
        }
    }

    @objc private func addButtonTapped() {
        guard let currentWeather = currentWeather, let locationName = locationName, let coordinate = coordinate else {
            return
        }
        
        saveWeatherLocation(name: locationName, coordinate: coordinate, weatherData: currentWeather)
        dismiss(animated: true) {
            NotificationCenter.default.post(name: Notification.Name("LocationAdded"), object: nil)
        }
    }
    
    @objc private func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }

    private func saveWeatherLocation(name: String, coordinate: CLLocationCoordinate2D, weatherData: CurrentWeatherResult) {
        // UserDefaults를 사용하여 위치 정보 저장해줘야됨
        let locations = UserDefaults.standard.array(forKey: "SavedLocations") as? [[String: Any]] ?? []
        let newLocation: [String: Any] = [
            "name": name,
            "latitude": coordinate.latitude,
            "longitude": coordinate.longitude,
            "temp": weatherData.main.temp,
            "description": weatherData.weather.first?.description ?? ""
        ]
        var updatedLocations = locations
        updatedLocations.append(newLocation)
        UserDefaults.standard.set(updatedLocations, forKey: "SavedLocations")
    }

    override func fetchWeatherData(for coordinate: CLLocationCoordinate2D) {
        super.fetchWeatherData(for: coordinate)
        // 추가 fetching 있으면 쓰고
    }
}
