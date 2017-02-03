//
//  CountriesPortraitViewCell.swift
//  LoadingView
//
//  Created by Vladimir Budniy on 12/1/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import UIKit

class CountriesPortraitViewCell: CountryViewCell {
    
    @IBOutlet var countryName: UILabel?
    @IBOutlet var capitalName: UILabel?
    
    // MARK: - Public
    
    override func fillWithModel<T: Country>(model: T) {
        self.countryName?.text = model.countryName
        self.capitalName?.text = model.capitalCity
    }
    
}
