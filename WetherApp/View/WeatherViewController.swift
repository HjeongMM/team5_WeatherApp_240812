//
//  ViewController.swift
//  Article 5 Project Testing2.
//
//  Created by 김동준 on 8/13/24.
//

import UIKit
import SnapKit

class WeatherViewController: UIViewController {

//     MARK: - UI Components
    
    let firstbutton: UIButton = {
        let firstbutton = UIButton(type: .system)
        firstbutton.setTitle("back", for: .normal)
        firstbutton.setTitleColor(.black, for: .normal)
        firstbutton.translatesAutoresizingMaskIntoConstraints = false
      firstbutton.addTarget(self, action: #selector(Firstinput), for: .touchDown)
        return firstbutton
    }()
    
    let Secondbutton: UIButton = {
        let Secondbutton = UIButton(type: .system)
        Secondbutton.setTitle("추가", for: .normal)
        Secondbutton.setTitleColor(.black, for: .normal)
        Secondbutton.translatesAutoresizingMaskIntoConstraints = false
      Secondbutton.addTarget(self, action: #selector(Secondinput), for: .touchDown)
        return Secondbutton
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 60, height: 100)
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        // Register cell class here
        collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "WeatherCollectionViewCell")
        return collectionView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        // Register cell class here
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: "WeatherTableViewCell")
        return tableView
    }()
    let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "(검색된) 위치"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    let weatherStatusView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        
        let weatherIcon = UIImageView()
        weatherIcon.image = UIImage(systemName: "sun.max")
        weatherIcon.contentMode = .scaleAspectFit
        
        let tempLabel = UILabel()
        tempLabel.text = "날씨상태\n최고: 34도\n최고 : 34도"
        tempLabel.numberOfLines = 0
        tempLabel.textAlignment = .center
        tempLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        view.addSubview(weatherIcon)
        view.addSubview(tempLabel)
        
        weatherIcon.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherIcon.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview().inset(8)
        }
        
        return view
    }()
    
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        collectionView.dataSource = self
        tableView.dataSource = self
    }
    
    // MARK: - Layout Setup
    func setupLayout() {
        view.addSubview(collectionView)
        view.addSubview(tableView)
        view.addSubview(locationLabel)
        view.addSubview(weatherStatusView)
        view.addSubview(firstbutton)
        view.addSubview(Secondbutton)
        
        firstbutton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(30)
        }
        
        Secondbutton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(330)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(100)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(300)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
        }
        
        weatherStatusView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(300)
        }
        
    }
}

// MARK: - UICollectionView DataSource
extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20 // Example number of items
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as! WeatherCollectionViewCell
        // Configure the cell with data here
        return cell
    }
}

// MARK: - UITableView DataSource
extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20 // Example number of rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
        // Configure the cell with data here
        return cell
    }
}

extension WeatherViewController {
    @objc func Firstinput() {
        print("firstclick")
    }
    @objc func Secondinput() {
        print("Secondclick")
    }
}
//
//import UIKit
//import SnapKit
//
//class ViewController: UIViewController {
//
//    private var dataSource = [ForecastWeather]()
//
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "서울특별시"
//        label.textColor = .white
//        label.font = .boldSystemFont(ofSize: 30)
//        return label
//    }()
//    private let tempLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .white
//        label.font = .boldSystemFont(ofSize: 50)
//        return label
//    }()
//    private let tempMinLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .white
//        label.font = .boldSystemFont(ofSize: 20)
//        return label
//    }()
//    private let tempMaxLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .white
//        label.font = .boldSystemFont(ofSize: 20)
//        return label
//    }()
//    private let tempStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.spacing = 20
//        stackView.distribution = .fillEqually
//        return stackView
//    }()
//    private let imageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        imageView.backgroundColor = .black
//        return imageView
//    }()
////    private lazy var tableView: UITableView = {
////        let tableView = UITableView()
////        tableView.backgroundColor = .black
////        tableView.delegate = self
////        tableView.dataSource = self
////        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.id)
////        return tableView
////    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        fetchWeatherData()
//        configureUI()
//    }
//
//    private func fetchWeatherData() {
//        let latitude = 37.5
//        let longitude = 126.9
//
//        // 현재 날씨 데이터를 가져옴
//        NetworkManager.shared.fetchCurrentWeatherData(lat: latitude, lon: longitude) { [weak self] currentWeather, image in
//            guard let self = self, let currentWeather = currentWeather else { return }
//
//            DispatchQueue.main.async {
//                self.tempLabel.text = "\(Int(currentWeather.main.temp))°C"
//                self.tempMinLabel.text = "최소: \(Int(currentWeather.main.temp_min))°C"
//                self.tempMaxLabel.text = "최고: \(Int(currentWeather.main.temp_max))°C"
//                self.imageView.image = image
//            }
//        }
//
//        // 5일 간의 날씨 예보 데이터를 가져옴
//        NetworkManager.shared.fetchForecastData(lat: latitude, lon: longitude) { [weak self] forecastResult in
//            guard let self = self, let forecastResult = forecastResult else { return }
//
//            DispatchQueue.main.async {
//                self.dataSource = forecastResult.list
//              //  self.tableView.reloadData()
//            }
//        }
//    }
//
//    private func configureUI() {
//        view.backgroundColor = .black
//        [
//            titleLabel,
//            tempLabel,
//            tempStackView,
//            imageView,
//            //tableView
//        ].forEach { view.addSubview($0) }
//
//        [
//            tempMinLabel,
//            tempMaxLabel
//        ].forEach { tempStackView.addArrangedSubview($0) }
//
//        titleLabel.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.top.equalToSuperview().offset(120)
//        }
//
//        tempLabel.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
//        }
//
//        tempStackView.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.top.equalTo(tempLabel.snp.bottom).offset(10)
//        }
//
//        imageView.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.width.height.equalTo(160)
//            $0.top.equalTo(tempStackView.snp.bottom).offset(20)
//        }
//
////        tableView.snp.makeConstraints {
////            $0.top.equalTo(imageView.snp.bottom).offset(30)
////            $0.leading.trailing.equalToSuperview().inset(20)
////            $0.bottom.equalToSuperview().inset(50)
////        }
//    }
//}
////
////extension ViewController: UITableViewDelegate {
////    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////        40
////    }
////}
//
////extension ViewController: UITableViewDataSource {
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.id) as? TableViewCell else { return UITableViewCell() }
////        cell.configureCell(forecastWeather: dataSource[indexPath.row])
////        return cell
////    }
////    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        dataSource.count
////    }
////}
