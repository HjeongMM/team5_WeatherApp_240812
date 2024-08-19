//
//  DetailDayViewController.swift
//  WetherApp
//
//  Created by 유민우 on 8/12/24.
//

import UIKit
import SnapKit

class DetailDayViewController: UIViewController {
    
    // MARK: - Property
    
    private var weatherData: CurrentWeatherResult?
    private var weatherIcon: UIImage?
    
    lazy var detailDayCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(WeatherDetailCollectionViewCell.self, forCellWithReuseIdentifier: WeatherDetailCollectionViewCell.id)
        collectionView.register(DetailDaySectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailDaySectionHeaderView.id)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Method
    
//    private func fetchWeatherData() {
//        let lat = 37.5665
//        let lon = 126.9780
//        
//        NetworkManager.shared.fetchCurrentWeatherData(lat: lat, lon) { [weak self] result in
//            switch result {
//            case .
//            }
//        }
//    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(detailDayCollectionView)
        
        detailDayCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().offset(-5)
            $0.bottom.equalToSuperview().offset(-15)
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            return self.createWeaterDetailSectionLayout()
        }
    }
    
    private func createWeaterDetailSectionLayout() -> NSCollectionLayoutSection {
        // 아이템 설정
        // 첫 번째 아이템(병합된 셀) 설정
        let fullWidthItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
        let fullWidthItem = NSCollectionLayoutItem(layoutSize: fullWidthItemSize)
        
        // 두 번째 아이템 설정
        let halfWidthItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let halfWidthItem = NSCollectionLayoutItem(layoutSize: halfWidthItemSize)
        
        // 수평 그룹(두 개의 셀을 나란히 배치) 설정
        let halfWidthGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
        let halfWidthGroup = NSCollectionLayoutGroup.horizontal(layoutSize: halfWidthGroupSize, subitem: halfWidthItem, count: 2)
        halfWidthGroup.interItemSpacing = .fixed(10)
        
        // 최종 수직 그룹 설정 (병합된 셀 + 두 개의 셀)
        let finalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(450))
        let finalGroup = NSCollectionLayoutGroup.vertical(layoutSize: finalGroupSize, subitems: [fullWidthItem, halfWidthGroup])
        finalGroup.interItemSpacing = .fixed(10)
        
        // 섹션 설정
        let section = NSCollectionLayoutSection(group: finalGroup)
        section.interGroupSpacing = 10
        
        // 헤더 추가
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(30))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        return section
    }
    
}

// MARK: - Extension

extension DetailDayViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let weatherData = weatherData, let weatherIcon = weatherIcon else {
            return WeatherDetailCollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherDetailCollectionViewCell.id, for: indexPath) as! WeatherDetailCollectionViewCell
        cell.configure(for: indexPath.item, with: weatherData, image: weatherIcon)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            fatalError("error")
        }
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailDaySectionHeaderView.id, for: indexPath) as! DetailDaySectionHeaderView
        
        headerView.configure(with: "2024년 08월 13일")
        return headerView
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
        
}
