//
//  FavoriteModalViewController.swift
//  WetherApp
//
//  Created by 임혜정 on 8/21/24.
//

import UIKit
import CoreLocation

class FavoriteModalViewController: UIViewController {
    private let mainView = MainView()
    private var currentWeather: CurrentWeatherResult?
    private var forecastWeather: ForecastWeatherResult?
    private let weatherDataManager = WeatherDataManager.shared
    private var forecastData: [ForecastWeather] = []
    private var savedLocationManager = SavedLocationManager.shared
    var savedLocation: SavedLocation?
    var coordinate: CLLocationCoordinate2D?
    
    private var favoriteModalView: MainView? {
        return view as? MainView
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupTableView()
        loadWeatherData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainView.addBordersToCollectionView()
    }
    
    private func setupCollectionView() {
        favoriteModalView?.collectionView.dataSource = self
        favoriteModalView?.collectionView.delegate = self
        favoriteModalView?.collectionView.register(ThreeHourlyCollectionViewCell.self, forCellWithReuseIdentifier: "ThreeHourlyCollectionViewCell")
    }
    
    private func setupTableView() {
        favoriteModalView?.tableView.dataSource = self
        favoriteModalView?.tableView.delegate = self
        favoriteModalView?.tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: "WeatherTableViewCell")
    }
    
    private func loadWeatherData() {
        guard let savedLocation = savedLocation else { return }
        
        let coordinate = CLLocationCoordinate2D(latitude: savedLocation.latitude, longitude: savedLocation.longitude)
        
        NetworkManager.shared.fetchCurrentWeatherData(lat: coordinate.latitude, lon: coordinate.longitude) { [weak self] result in
            switch result {
            case .success(let weatherData):
                self?.currentWeather = weatherData
                DispatchQueue.main.async {
                    self?.updateUI()
                }
            case .failure(let error):
                print("\(error)")
            }
        }
        
        NetworkManager.shared.fetchForecastData(lat: coordinate.latitude, lon: coordinate.longitude) { [weak self] result in
            switch result {
            case .success(let forecastData):
                self?.forecastWeather = forecastData
                self?.forecastData = forecastData.list
                DispatchQueue.main.async {
                    self?.favoriteModalView?.collectionView.reloadData()
                    self?.favoriteModalView?.tableView.reloadData()
                }
            case .failure(let error):
                print("\(error)")
            }
        }
    }
    
    private func updateUI() {
        guard let currentWeather = currentWeather else { return }
        
        favoriteModalView?.updateLocationLabel(savedLocation?.name ?? "알 수 없는 위치")
        
        let formattedData = weatherDataManager.formatWeatherData(currentWeather)
        favoriteModalView?.updateWeatherUI(with: formattedData)
        
        if let weatherStatus = currentWeather.weather.first?.main {
            let translatedStatus = WeatherDataFormatter.shared.translateWeatherCondition(weatherStatus)
            favoriteModalView?.updateWeatherStatus(translatedStatus)
        }
        
        if let weatherIcon = currentWeather.weather.first?.main {
            let iconName = WeatherDataFormatter.shared.iconWeatherCondition(weatherIcon)
            favoriteModalView?.updateWeatherIcon(iconName)
        }
    }
}

extension FavoriteModalViewController: UICollectionViewDataSource, UICollectionViewDelegate {
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

extension FavoriteModalViewController: UITableViewDataSource, UITableViewDelegate {
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




