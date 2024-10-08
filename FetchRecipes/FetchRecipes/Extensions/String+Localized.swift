//
//  String+Localized.swift
//  FetchRecipes
//
//  Created by Oren Leavitt on 10/7/24.
//

import Foundation

extension String {
    
    func localized() -> String {
        NSLocalizedString(self, comment: "")
    }
}
