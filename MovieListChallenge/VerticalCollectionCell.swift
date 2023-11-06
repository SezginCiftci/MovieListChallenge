//
//  VerticalCollectionCell.swift
//  MovieListChallenge
//
//  Created by Sezgin Çiftci on 4.11.2023.
//

import UIKit
import Kingfisher

protocol VerticalCollectionCellInterface: AnyObject {
    func prepareCollectionView()
    func reloadCollectionView()
}

final class VerticalCollectionCell: UICollectionViewCell, VerticalCollectionCellInterface {
    
    @IBOutlet weak var verticalCellCollectionView: UICollectionView!
    
    var viewModel: VerticalCellViewModelInterface!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        viewModel.layoutSubViews()
    }
    
    func prepareCollectionView() {
        verticalCellCollectionView.delegate = self
        verticalCellCollectionView.dataSource = self
        verticalCellCollectionView.register(cellType: HorizontalCollectionCell.self)
    }
    
    func reloadCollectionView() {
        verticalCellCollectionView.reloadData()
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
        return viewModel.numberOfRow(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: HorizontalCollectionCell.self, indexPath: indexPath)
        cell.titleLabel.text = viewModel.cellForRow(at: indexPath)?.name
        cell.subTitleLabel.text = viewModel.cellForRow(at: indexPath)?.rating
        cell.cellImageView.kf.setImage(with: viewModel.cellForRow(at: indexPath)?.posterURL)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath)
    }
}
