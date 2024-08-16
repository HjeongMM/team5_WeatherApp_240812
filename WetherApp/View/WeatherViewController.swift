////
////  MainView.swift
////  WetherApp
////
////  Created by 임혜정 on 8/12/24.
////
//
//  ViewController.swift
//  Article 5 Project Testing2.
//
//  Created by 김동준 on 8/13/24.
//
//    // MARK: - UI Components
//    let collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.itemSize = CGSize(width: 60, height: 100)
//        layout.minimumLineSpacing = 10
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.backgroundColor = .white
//        // Register cell class here
//        collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "WeatherCollectionViewCell")
//        return collectionView
//    }()
//    
//    let tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.separatorStyle = .none
//        // Register cell class here
//        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: "WeatherTableViewCell")
//        return tableView
//    }()
//    
//    let locationLabel: UILabel = {
//        let label = UILabel()
//        label.text = "(검색된) 위치"
//        label.textAlignment = .center
//        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
//        return label
//    }()
//    
//    let weatherStatusView: UIView = {
//        let view = UIView()
//        view.layer.cornerRadius = 8
//        view.backgroundColor = .white
//        
//        let weatherIcon = UIImageView()
//        weatherIcon.image = UIImage(systemName: "sun.max")
//        weatherIcon.contentMode = .scaleAspectFit
//        
//        let tempLabel = UILabel()
//        tempLabel.text = "날씨상태\n최고: 34도\n최고 : 34도"
//        tempLabel.numberOfLines = 0
//        tempLabel.textAlignment = .center
//        tempLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
//        
//        view.addSubview(weatherIcon)
//        view.addSubview(tempLabel)
//        
//        weatherIcon.snp.makeConstraints {
//            $0.top.centerX.equalToSuperview()
//            $0.size.equalTo(CGSize(width: 40, height: 40))
//        }
//        
//        tempLabel.snp.makeConstraints {
//            $0.top.equalTo(weatherIcon.snp.bottom).offset(8)
//            $0.leading.trailing.bottom.equalToSuperview().inset(8)
//        }
//        
//        return view
//    }()
//    
//    
//    
//    // MARK: - View Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupLayout()
//        collectionView.dataSource = self
//        tableView.dataSource = self
//    }
//    
//    // MARK: - Layout Setup
//    func setupLayout() {
//        view.addSubview(collectionView)
//        view.addSubview(tableView)
//        view.addSubview(locationLabel)
//        view.addSubview(weatherStatusView)
//        
//        collectionView.snp.makeConstraints {
//            $0.leading.trailing.equalToSuperview().inset(16)
//            $0.height.equalTo(100)
//        }
//        
//        tableView.snp.makeConstraints {
//            $0.top.equalTo(collectionView.snp.bottom)
//            $0.leading.trailing.equalToSuperview().inset(16)
//            $0.height.equalTo(300)
//            $0.bottom.equalTo(view.safeAreaLayoutGuide)
//        }
//        
//        locationLabel.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
//            $0.centerX.equalToSuperview()
//        }
//        
//        weatherStatusView.snp.makeConstraints {
//            $0.top.equalToSuperview().offset(60)
//            $0.centerX.equalToSuperview()
//            $0.width.equalToSuperview().multipliedBy(0.8)
//            $0.height.equalTo(300)
//        }
//    }
//}
//
//// MARK: - UICollectionView DataSource
//extension MainView: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 20 // Example number of items
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as! WeatherCollectionViewCell
//        // Configure the cell with data here
//        return cell
//    }
//}
//
//// MARK: - UITableView DataSource
//extension MainView: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 20 // Example number of rows
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
//        // Configure the cell with data here
//        return cell
//    }
//}
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
