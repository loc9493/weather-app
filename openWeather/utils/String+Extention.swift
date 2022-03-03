//
//  String+Extention.swift
//  openWeather
//
//  Created by Nguyen Loc on 3/3/22.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
