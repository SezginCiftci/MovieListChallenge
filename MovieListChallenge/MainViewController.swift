//
//  MainViewController.swift
//  MovieListChallenge
//
//  Created by Sezgin Çiftci on 3.11.2023.
//

import UIKit

protocol MainViewInterface: AnyObject {
    func prepareCollectionView()
    func prepareNavigationBar(navbarTitle: String, bgColor: String, textColor: String)
    func reloadCollectionView()
}

final class MainViewController: UIViewController, MainViewInterface {
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    private var viewModel: MainViewModelInterface!
    
    //MARK: ViewController Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    //MARK: MainViewInterface Methods
    func prepareCollectionView() {
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.register(cellType: VerticalCollectionCell.self)
        mainCollectionView.registerView(cellType: MainCollectionHeader.self)
    }
    
    func reloadCollectionView() {
        mainCollectionView.reloadData()
    }
    
    func prepareNavigationBar(navbarTitle: String, bgColor: String, textColor: String) {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = navbarTitle
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor(named: bgColor)
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: textColor)!]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: textColor)!]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }
}

//MARK: VerticalCell Delegate Methods
extension MainViewController: VerticalCollectionCellDelegate {
    func didSelectShow(showId: Int) {
        let detailVC = DetailViewController()
        let detailVM = DetailViewModel(showId: showId)
        detailVC.viewModel = detailVM
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

//MARK: CollectionView Methods
extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: VerticalCollectionCell.self, indexPath: indexPath)
        let cellViewModel = VerticalCellViewModel(view: cell,
                                                  tvShows: viewModel.cellForRow(at: indexPath),
                                                  delegate: self)
        cell.viewModel = cellViewModel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeView(cellType: MainCollectionHeader.self, indexPath: indexPath)
        header.headerTitle.text = viewModel.titleForHeader(at: indexPath)
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
