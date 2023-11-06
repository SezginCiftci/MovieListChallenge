//
//  DetailViewController.swift
//  MovieListChallenge
//
//  Created by Sezgin Çiftci on 3.11.2023.
//

import UIKit
import Kingfisher

protocol DetailViewInterface: AnyObject, AlertPresentable {
    func configureNavigationBar(barTitle: String,
                                prefersLargeTitle: Bool,
                                barBgColorStr: String,
                                barTitleColorStr: String)
    func updateUI()
    func configureLoading(isLoading: Bool)
}

final class DetailViewController: UIViewController, DetailViewInterface {
    
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var relaseDateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet var starImages: [UIImageView]!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var loadingAnimation: UIActivityIndicatorView!
    
    var viewModel: DetailViewModelInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    func updateUI() {
        title = viewModel.showTitle
        descriptionLabel.text = viewModel.overview
        timeLabel.text = viewModel.runTime
        relaseDateLabel.text = viewModel.firstAir
        topImageView.kf.setImage(with: URL(string: viewModel.topImageURL))
        posterImageView.kf.setImage(with: URL(string: viewModel.posterImageURL))
        let _ = viewModel.getStarImageNames.enumerated().map { index, starStr in
            starImages[index].image = UIImage(systemName: starStr.starImageName)
        }
    }
    
    func configureLoading(isLoading: Bool) {
        isLoading ? loadingAnimation.startAnimating() : loadingAnimation.stopAnimating()
    }
    
    @IBAction func visitHomePageButtonTapped(_ sender: UIButton) {
        if let homeURL = viewModel.homepage {
            UIApplication.shared.open(homeURL)
        }
    }
    
}
