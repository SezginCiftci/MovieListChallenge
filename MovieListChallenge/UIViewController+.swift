//
//  UIViewController+.swift
//  MovieListChallenge
//
//  Created by Sezgin Çiftci on 4.11.2023.
//

import UIKit

extension UIViewController {
    func configureNavigationBar(barTitle: String,
                                prefersLargeTitle: Bool = true,
                                barBgColorStr: String,
                                barTitleColorStr: String) {
        navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitle
        title = barTitle
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor(named: barBgColorStr)
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: barTitleColorStr)!]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: barTitleColorStr)!]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }
}
