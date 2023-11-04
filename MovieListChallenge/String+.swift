//
//  String+.swift
//  MovieListChallenge
//
//  Created by Sezgin Çiftci on 4.11.2023.
//

import Foundation

extension Optional where Wrapped == String {
    func configureDate() -> String? {
        guard let self else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: self) else { return nil }
        let locale = Locale(identifier: "en-US")
        dateFormatter.locale = locale
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "dd/MM/yyyy", options: 0, locale: locale)
        return dateFormatter.string(from: date)
    }
}
