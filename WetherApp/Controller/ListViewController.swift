//
//  ListViewController.swift
//  WetherApp
//
//  Created by t2023-m0112 on 8/12/24.
//

import UIKit
import CoreLocation

class ListViewController: UIViewController, UISearchBarDelegate {
    private let listView = ListView()
    private let locationManager = LocationManager.shared
    private var weatherDataManager = WeatherDataManager.shared
    private var filteredLocations: [LocationResult] = []
    private var currentWeather: CurrentWeatherResult?
    var isHiddenFlag: Bool = false
    
    override func loadView() {
        view = listView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        
    }
    
    private func setupDelegates() {
        listView.searchBar.delegate = self
        listView.locationSearchCollectionView.delegate = self
        listView.locationSearchCollectionView.dataSource = self
    }
    
    // MARK: - 서치바 Delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredLocations.removeAll()
            listView.locationSearchCollectionView.reloadData()
            listView.locationSearchCollectionView.isHidden = true
        } else {
            fetchLocations(for: searchText)
            listView.locationSearchCollectionView.isHidden = false
        }
    }
    
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        listView.locationSearchCollectionView.isHidden = false
    }
    
    // MARK: - 사용자가 입력한 검색어로 지역 목록을 가져오는 부분
    
    private func fetchLocations(for query: String) {
        NetworkManager.shared.fetchLocations(for: query) { [weak self] result in
            switch result {
            case .success(let locations):
                self?.filteredLocations = locations
                DispatchQueue.main.async {
                    self?.listView.locationSearchCollectionView.reloadData()
                }
            case .failure(let error):
                print("\(error)")
            }
        }
    }
    
    private func fetchWeatherForLocation(lat: Double, lon: Double, locationName: String) {
        NetworkManager.shared.fetchCurrentWeatherData(lat: lat, lon: lon) { [weak self] result in
            switch result {
            case .success(let currentWeather):
                DispatchQueue.main.async {
                    self?.presentAddRegionViewController(weatherData: currentWeather, locationName: locationName)
                }
            case .failure(let error):
                print("Failed to fetch weather data: \(error)")
            }
        }
    }
    
    
    // MARK: - 선택된 지역의 날씨 정보 표시
    
    func presentAddRegionViewController(weatherData: CurrentWeatherResult, locationName: String) {
        let addRegionViewController = AddRegionViewController()
        addRegionViewController.currentWeather = weatherData
        addRegionViewController.locationName = locationName
        addRegionViewController.modalPresentationStyle = .pageSheet
        present(addRegionViewController, animated: true, completion: nil)
    }
}


// MARK: - 컬렉션 뷰 Delegate, DataSource

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedLocation = filteredLocations[indexPath.row]
        fetchWeatherForLocation(lat: selectedLocation.lat, lon: selectedLocation.lon, locationName: "\(selectedLocation.name), \(selectedLocation.country)")
        listView.locationSearchCollectionView.isHidden = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredLocations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListView.cellIdentifier, for: indexPath) as? ListCollectionViewCell else {
            return UICollectionViewCell()
        }
        let location = filteredLocations[indexPath.row]
        cell.configure(with: location.formattedKoreanLocationName())
        return cell
    }
}
