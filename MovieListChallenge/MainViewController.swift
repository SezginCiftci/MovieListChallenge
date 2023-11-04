//
//  MainViewController.swift
//  MovieListChallenge
//
//  Created by Sezgin Çiftci on 3.11.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    //MARK: ViewController Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.register(cellType: VerticalCollectionCell.self)
        mainCollectionView.registerView(cellType: MainCollectionHeader.self)
    }
}

//MARK: CollectionView Methods
extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: VerticalCollectionCell.self, indexPath: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeView(cellType: MainCollectionHeader.self, indexPath: indexPath)
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 20), height: (collectionView.frame.height - 20)/3)
    }
}
