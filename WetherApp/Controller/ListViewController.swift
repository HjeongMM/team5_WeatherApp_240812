//
//  ListViewController.swift
//  WetherApp
//
//  Created by t2023-m0112 on 8/12/24.
//

import UIKit

class ListViewController: UIViewController, UISearchBarDelegate {
    let listView = ListView()
    var filteredLocations: [LocationResult] = [] // 자동완성을 위한 지역 목록
    
    override func loadView() {
        view = listView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listView.searchBar.delegate = self
        listView.weatherCollectionView.delegate = self
        listView.weatherCollectionView.dataSource = self
    }
    
    // 사용자가 검색어를 입력할 때마다 호출되는 메서드
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredLocations.removeAll()
            listView.weatherCollectionView.reloadData()
            return
        }
        
        fetchLocations(for: searchText)
    }
    
    // 사용자가 지역을 검색하면 해당 텍스트를 API로 전송하여 지역 목록을 가져옴
    func fetchLocations(for query: String) {
        let urlString = "https://api.openweathermap.org/geo/1.0/direct?q=\(query)&limit=5&appid=1ad11a058dd751ada3c5aa999ddc64a8"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else { return }
            
            do {
                // 배열로 디코딩 시도
                let locationResults = try JSONDecoder().decode([LocationResult].self, from: data)
                self.filteredLocations = locationResults
            } catch DecodingError.typeMismatch {
                // 사전으로 디코딩 시도
                do {
                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    print("Error response from API: \(errorResponse.message)")
                    return
                } catch {
                    print("Failed to decode JSON as ErrorResponse: \(error)")
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
            
            DispatchQueue.main.async {
                self.listView.weatherCollectionView.reloadData() // 검색 결과를 컬렉션 뷰에 표시
            }
        }.resume()
    }
    
    // 선택한 지역에 대한 날씨 정보를 가져와 모달로 표시
    func fetchWeatherForLocation(location: LocationResult) {
        NetworkManager.shared.fetchCurrentWeatherData(lat: location.lat, lon: location.lon) { [weak self] result in
            switch result {
            case .success(let weatherData):
                DispatchQueue.main.async {
                    self?.presentAddRegionViewController(weatherData: weatherData, locationName: "\(location.name), \(location.country)")
                }
            case .failure(let error):
                print("Failed to fetch weather data: \(error)")
            }
        }
    }
    
    func presentAddRegionViewController(weatherData: CurrentWeatherResult, locationName: String) {
        let addRegionViewController = AddRegionViewController()
        addRegionViewController.weatherData = weatherData  // weatherData 설정
        addRegionViewController.locationName = locationName  // locationName 설정
        addRegionViewController.modalPresentationStyle = .pageSheet
        present(addRegionViewController, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedLocation = filteredLocations[indexPath.row]
        fetchWeatherForLocation(location: selectedLocation)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredLocations.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListView.cellIdentifier, for: indexPath) as? ListCollectionViewCell else {
            return UICollectionViewCell() // 대체 셀 반환
        }
        let location = filteredLocations[indexPath.row]
        cell.configure(with: "\(location.name), \(location.country)")
        return cell
    }
}
