////
////  MainViewController.swift
////  WetherApp
////
////  Created by 임혜정 on 8/12/24.
////
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    private let mainView = MainView()
    private var currentLocation: CLLocation?
    private let locationManager = LocationManager.shared
    private let weatherDataManager = WeatherDataManager()
    private var currentWeather: CurrentWeatherResult?
    private var forecastData: [ForecastWeather] = []
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainDarkGray
        mainView.collectionView.dataSource = self
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        setupLocationManager()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.requestCurrentLocation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainView.addBordersToCollectionView()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestLocationAuthorization()
    }
    
    func fetchWeatherData(for coordinate: CLLocationCoordinate2D) {
        let lat = coordinate.latitude
        let lon = coordinate.longitude
        
        NetworkManager.shared.fetchCurrentWeatherData(lat: lat, lon: lon) { [weak self] result in
            switch result {
            case .success(let currentWeather):
                self?.currentWeather = currentWeather
                DispatchQueue.main.async {
                    self?.updateCurrentWeatherUI()
                }
            case .failure(let error):
                print("Failed to fetch current weather data: \(error)")
            }
        }
        
        NetworkManager.shared.fetchForecastData(lat: lat, lon: lon) { [weak self] result in
            switch result {
            case .success(let forecast):
                self?.forecastData = forecast.list
                DispatchQueue.main.async {
                    self?.mainView.collectionView.reloadData()
                    self?.mainView.tableView.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch forecast data: \(error)")
            }
        }
    }
    
    func updateCurrentWeatherUI() {
        guard let currentWeather = currentWeather else { return }
        
        let formattedData = weatherDataManager.formatWeatherData(currentWeather)
        mainView.updateWeatherUI(with: formattedData)
        
        if let weatherStatus = currentWeather.weather.first?.main {
            let translatedStatus = WeatherDataFormatter.shared.translateWeatherCondition(weatherStatus)
            mainView.updateWeatherStatus(translatedStatus)
        }
        
        if let location = currentLocation {
            weatherDataManager.getLocationName(from: location) { [weak self] locationName in
                DispatchQueue.main.async {
                    self?.mainView.updateLocationLabel(locationName)
                }
            }
        } else {
            mainView.updateLocationLabel("현재 위치")
        }
        
        if let currentWeatherIcon = currentWeather.weather.first?.main {
            let iconName = WeatherDataFormatter.shared.iconWeatherCondition(currentWeatherIcon)
            mainView.updateWeatherIcon(iconName)
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return WeatherDataFormatter.shared.filterThreeHourlyForecasts(forecastData).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThreeHourlyCollectionViewCell", for: indexPath) as! ThreeHourlyCollectionViewCell
        let threeHourlyForecasts = WeatherDataFormatter.shared.filterThreeHourlyForecasts(forecastData)
        let forecast = threeHourlyForecasts[indexPath.row]
        let iconName = WeatherDataFormatter.shared.iconWeatherCondition(forecast.weather.first?.main ?? "")
        cell.configure(with: forecast, formatter: WeatherDataFormatter.shared, iconName: iconName)
        return cell
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WeatherDataFormatter.shared.filterForecastData(forecastData).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
        let dailyForecasts = WeatherDataFormatter.shared.filterForecastData(forecastData)
        let forecast = dailyForecasts[indexPath.row]
        
        let day = WeatherDataFormatter.shared.formatDayString(from: forecast.dtTxt, isToday: indexPath.row == 0)
        let temperature = "\(Int(forecast.main.temp))°C"
        let iconName = WeatherDataFormatter.shared.iconWeatherCondition(forecast.weather.first?.main ?? "")
        cell.configure(day: day, temperature: temperature, iconName: iconName)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // 셀이 선택될 경우 동작 구현
            print("눌림. 상세페이지로의 연결이 끝나면 삭제할 라인")
        }

    
}

// MARK: - 위치관련 , 분리 작업 예정

extension MainViewController: LocationManagerDelegate {
    func locationManager(_ manager: LocationManager, didUpdateLocation location: CLLocation) {
        currentLocation = location
        fetchWeatherData(for: location.coordinate)
    }
    
    func locationManager(_ manager: LocationManager, didFailWithError error: Error) {
        print("Failed to get user's location: \(error.localizedDescription)")
        showLocationDeniedAlert()
    }
    
    private func showLocationDeniedAlert() {
        let alert = UIAlertController(
            title: "위치 접근 거부됨",
            message: "날씨 정보를 제공하기 위해 위치 접근 권한이 필요합니다. 설정에서 위치 접근을 허용해주세요.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL)
            }
        })
        alert.addAction(UIAlertAction(title: "취소", style: .cancel) { _ in
            let defaultCoordinate = CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780)
            self.fetchWeatherData(for: defaultCoordinate)
        })
        present(alert, animated: true)
    }
}

//api.openweathermap.org/data/2.5/forecast?lat=37.5665&lon=126.9780&appid=1ad11a058dd751ada3c5aa999ddc64a8
