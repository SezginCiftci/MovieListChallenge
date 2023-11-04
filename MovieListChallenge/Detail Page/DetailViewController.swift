//
//  DetailViewController.swift
//  MovieListChallenge
//
//  Created by Sezgin Çiftci on 3.11.2023.
//

import UIKit
import Kingfisher

protocol DetailViewInterface: AnyObject {
    func prepareNavigationBar()
    func updateUI(showTitle: String, description: String, runTime: String, firstAir: String, starArray: [String], topImageURL: String, posterImageURL: String)
}

final class DetailViewController: UIViewController, DetailViewInterface {
    
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var relaseDateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet var starImages: [UIImageView]!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var viewModel: DetailViewModelInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.view = self
        viewModel.viewDidLoad()
    }
    
    //TODO: Reusable bir yolunu bulmak lazım. Belli custom navigation olabilir.
    func prepareNavigationBar() {
//        navigationController?.navigationBar.prefersLargeTitles = true
//        title = "Detail"
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithTransparentBackground()
//        appearance.backgroundColor = UIColor.blue
//        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//        navigationItem.standardAppearance = appearance
//        navigationItem.scrollEdgeAppearance = appearance
    }
    
    func updateUI(showTitle: String,
                  description: String,
                  runTime: String,
                  firstAir: String,
                  starArray: [String],
                  topImageURL: String,
                  posterImageURL: String) {
        title = showTitle
        descriptionLabel.text = description
        timeLabel.text = "\(runTime) min."
        relaseDateLabel.text = firstAir //TODO: DateFormat işi var
        topImageView.kf.setImage(with: URL(string: topImageURL))
        posterImageView.kf.setImage(with: URL(string: posterImageURL))
        let _ = starArray.enumerated().map { index, starStr in
            starImages[index].image = UIImage(systemName: starStr)
        }
    }
    
    @IBAction func visitHomePageButtonTapped(_ sender: UIButton) {
    }
    
}
