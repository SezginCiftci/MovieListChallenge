//
//  VerticalCollectionCell.swift
//  MovieListChallenge
//
//  Created by Sezgin Çiftci on 4.11.2023.
//

import UIKit

final class VerticalCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var verticalCellCollectionView: UICollectionView!
    
    var tvShows: [TvResult] = [] {
        didSet {
            verticalCellCollectionView.reloadData()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        verticalCellCollectionView.delegate = self
        verticalCellCollectionView.dataSource = self
        verticalCellCollectionView.register(cellType: HorizontalCollectionCell.self)
    }
}

//MARK: CollectionView Methods
extension VerticalCollectionCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.frame.width - 20)/2, height: collectionView.frame.height - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvShows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: HorizontalCollectionCell.self, indexPath: indexPath)
        cell.titleLabel.text = tvShows[indexPath.row].name
//        cell.subTitleLabel.text = "Subtitle Deneme"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO:
    }
}
