//
//  ListView.swift
//  WetherApp
//
//  Created by t2023-m0112 on 8/12/24.
//

import UIKit
import SnapKit

class ListView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - UI Elements
    
    let locationSearchLabel: UILabel = {
        let label = UILabel()
        label.text = "위치 검색"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "도시 또는 공항 검색"
        searchBar.backgroundImage = UIImage()
        return searchBar
    }()
    
    let weatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        
        let weatherCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        weatherCollectionView.backgroundColor = .white
        return weatherCollectionView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
        weatherCollectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: "WeatherCell")
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as! ListCollectionViewCell
        return cell
    }
}
// 미리보기
import SwiftUI

struct ListViewRepresentable: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        return ListView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListViewRepresentable()
            .edgesIgnoringSafeArea(.all)
            .previewDevice("iPhone 14")
            .previewDisplayName("iPhone 14 - iOS 16")
    }
}
