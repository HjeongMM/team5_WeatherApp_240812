//
//  AddRegionViewController.swift
//  WetherApp
//
//  Created by t2023-m0112 on 8/19/24.
//

import UIKit
import CoreLocation

class AddRegionViewController: UIViewController {
    private let mainView = MainView()
    private var currentWeather: CurrentWeatherResult?
    private var forecastWeather: ForecastWeatherResult?
    private let weatherDataManager = WeatherDataManager.shared
    private var forecastData: [ForecastWeather] = []
    private var savedLocationManager = SavedLocationManager.shared
    var locationName: String?
    var coordinate: CLLocationCoordinate2D?
    
    private var addRegionView: MainView? {
        return view as? MainView
    }
    
    override func loadView() {
        view = mainView
        addRegionView?.addAddButton()
        addRegionView?.addCancelButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCancelAddButton()
        setupCollectionView()
        setupTableView()
        fetchWeatherData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainView.addBordersToCollectionView()
    }
    
    private func setupCancelAddButton() {
        addRegionView?.addButton?.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addRegionView?.cancelButton?.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    private func setupCollectionView() {
        addRegionView?.collectionView.dataSource = self
        addRegionView?.collectionView.delegate = self
        addRegionView?.collectionView.register(ThreeHourlyCollectionViewCell.self, forCellWithReuseIdentifier: "ThreeHourlyCollectionViewCell")
    }

    private func setupTableView() {
            addRegionView?.tableView.dataSource = self
            addRegionView?.tableView.delegate = self
            addRegionView?.tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: "WeatherTableViewCell")
        }
    
    private func fetchWeatherData() {
        guard let coordinate = coordinate else { return }
     
        let group = DispatchGroup()
        
        group.enter()
        NetworkManager.shared.fetchCurrentWeatherData(lat: coordinate.latitude, lon: coordinate.longitude) { [weak self] result in
            defer { group.leave() }
            switch result {
            case .success(let weatherData):
                self?.currentWeather = weatherData
            case .failure(let error):
                print(" \(error)")
            }
        }
        
        group.enter()
        NetworkManager.shared.fetchForecastData(lat: coordinate.latitude, lon: coordinate.longitude) { [weak self] result in
            defer { group.leave() }
            switch result {
            case .success(let forecastData):
                self?.forecastWeather = forecastData
                self?.forecastData = forecastData.list
            case .failure(let error): print(" \(error)")
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.updateUI()
        }
    }
    
    func updateUI() {
        guard let currentWeather = currentWeather else { return }
        
        addRegionView?.updateLocationLabel(locationName ?? "알 수 없는 위치")
        
        let formattedData = weatherDataManager.formatWeatherData(currentWeather)
        addRegionView?.updateWeatherUI(with: formattedData)
        
        if let weatherStatus = currentWeather.weather.first?.main {
            let translatedStatus = WeatherDataFormatter.shared.translateWeatherCondition(weatherStatus)
            addRegionView?.updateWeatherStatus(translatedStatus)
        }
        
        if let weatherIcon = currentWeather.weather.first?.main {
            let iconName = WeatherDataFormatter.shared.iconWeatherCondition(weatherIcon)
            addRegionView?.updateWeatherIcon(iconName)
        }
        
        DispatchQueue.main.async {
                    self.addRegionView?.collectionView.reloadData()
                    self.addRegionView?.tableView.reloadData()
                }
    }
    
    @objc private func addButtonTapped() {
        guard
            let currentWeather = currentWeather,
            let locationName = locationName,
            let coordinate = coordinate 
        else {
            return
        }
        
        let savedLocation = SavedLocation(
            name: locationName,
            latitude: coordinate.latitude,
            longitude: coordinate.longitude,
            temp: currentWeather.main.temp,
            description: currentWeather.weather.first?.description ?? ""
        )
        
        SavedLocationManager.shared.saveLocation(savedLocation)
        
        dismiss(animated: true) {
            NotificationCenter.default.post(name: Notification.Name("LocationAdded"), object: nil)
        }
    }
    
    @objc private func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}



extension AddRegionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return WeatherDataFormatter.shared.filterThreeHourlyForecasts(forecastData).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThreeHourlyCollectionViewCell", for: indexPath) as? ThreeHourlyCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let threeHourlyForecasts = WeatherDataFormatter.shared.filterThreeHourlyForecasts(forecastData)
        let forecast = threeHourlyForecasts[indexPath.row]
        let iconName = WeatherDataFormatter.shared.iconWeatherCondition(forecast.weather.first?.main ?? "")
        cell.configure(with: forecast, formatter: WeatherDataFormatter.shared, iconName: iconName)
        
        return cell
    }
}

extension AddRegionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WeatherDataFormatter.shared.filterForecastData(forecastData).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as? WeatherTableViewCell else {
            return UITableViewCell()
        }
        
        let dailyForecasts = WeatherDataFormatter.shared.filterForecastData(forecastData)
        let forecast = dailyForecasts[indexPath.row]
        let day = WeatherDataFormatter.shared.formatDayString(from: forecast.dtTxt, isToday: indexPath.row == 0)
        let temperature = "\(Int(forecast.main.temp))°C"
        let iconName = WeatherDataFormatter.shared.iconWeatherCondition(forecast.weather.first?.main ?? "")
        cell.configure(day: day, temperature: temperature, iconName: iconName)
        
        return cell
    }
}
