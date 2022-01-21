//
//  WeatherHourlyTableViewCell.swift
//  WeatherTest
//
//  Created by Tata on 19/11/21.
//

import UIKit
import CoreLocation

class WeatherHourlyTableViewCell: UITableViewCell {
    
    static let identifier = "WeatherHourlyTableViewCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
                    
    var setTemp: ((WeekCollectionViewCell, IndexPath)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
    }
    
    private func configCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(WeekCollectionViewCell.self, forCellWithReuseIdentifier: WeekCollectionViewCell.identifier)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherHourlyTableViewCell", bundle: nil)
    }
}

//MARK: - Data source

extension WeatherHourlyTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekCollectionViewCell.identifier, for: indexPath) as? WeekCollectionViewCell else { return UICollectionViewCell() }
        cell.configCell()
        cell.backgroundColor = .clear
        cell.addCornerRadius(contentView: cell, cornerRadius: 15, borderWidth: 0.05, color: .gray)
        setTemp?(cell, indexPath)
        
        return cell
    }
}
//MARK: - Flow layout

extension WeatherHourlyTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: contentView.frame.width / 4.8, height: collectionView.frame.height - 30)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
}
