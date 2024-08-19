//
//  ListView.swift
//  WetherApp
//
//  Created by t2023-m0112 on 8/12/24.
//

import UIKit
import SnapKit

class ListView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - Static Properties
    
    static let cellIdentifier = "WeatherCell"
    
    // MARK: - UI Elements
    
    let locationSearchLabel: UILabel = {
        let label = UILabel()
        label.text = "위치 검색"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .mainGreen // 텍스트 색상을 mainGreen으로 설정
        return label
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "도시 또는 공항 검색"
        searchBar.backgroundImage = UIImage()
        searchBar.tintColor = .mainGreen // 서치바의 커서와 버튼 색상을 mainGreen으로 설정
        searchBar.searchTextField.textColor = .mainGreen // 서치바 텍스트 색상 mainGreen으로 설정
        searchBar.searchTextField.layer.borderColor = UIColor.mainGreen.cgColor // 서치바 테두리 색상을 mainGreen으로 설정
        searchBar.searchTextField.layer.borderWidth = 1.0 // 서치바 테두리 두께 설정
        searchBar.searchTextField.layer.cornerRadius = 10 // 서치바 테두리의 둥글기 설정
        searchBar.searchTextField.clipsToBounds = true

        // 플레이스홀더 텍스트 색상을 mainGreen으로 설정
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.mainGreen
        ]
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "도시 또는 공항 검색", attributes: placeholderAttributes)

        // 돋보기 아이콘 색상 변경
        if let glassIconView = searchBar.searchTextField.leftView as? UIImageView {
            glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
            glassIconView.tintColor = .mainGreen
        }

        return searchBar
    }()

    let weatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        
        let weatherCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        weatherCollectionView.backgroundColor = .mainDarkGray // 컬렉션 뷰의 배경색을 mainDarkGray로 설정
        return weatherCollectionView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .mainDarkGray // 뷰의 배경색을 mainDarkGray로 설정
        setupView()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .mainDarkGray // 뷰의 배경색을 mainDarkGray로 설정
        setupView()
        setupCollectionView()
    }
    
    // MARK: - Setup Methods
    
    private func setupView() {
        [locationSearchLabel, searchBar, weatherCollectionView].forEach {
            addSubview($0)
        }
        locationSearchLabel.snp.makeConstraints {
            $0.left.equalTo(safeAreaLayoutGuide.snp.left).offset(16)
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(12)
            $0.width.equalTo(200)
            $0.height.equalTo(30)
        }
        
        searchBar.snp.makeConstraints {
            $0.left.equalTo(safeAreaLayoutGuide.snp.left).offset(8)
            $0.right.equalTo(safeAreaLayoutGuide.snp.right).offset(-8)
            $0.top.equalTo(locationSearchLabel.snp.bottom).offset(8)
            $0.height.equalTo(50)
        }
        
        weatherCollectionView.snp.makeConstraints {
            $0.left.right.equalTo(searchBar)
            $0.top.equalTo(searchBar.snp.bottom).offset(8)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
    }
    
    private func setupCollectionView() {
        weatherCollectionView.dataSource = self
        weatherCollectionView.delegate = self
        weatherCollectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListView.cellIdentifier)
    }
    
    // MARK: - Layout Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let layout = weatherCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = safeAreaLayoutGuide.layoutFrame.width
            let itemWidth = width - 32
            layout.itemSize = CGSize(width: itemWidth, height: 100)
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListView.cellIdentifier, for: indexPath) as? ListCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}
