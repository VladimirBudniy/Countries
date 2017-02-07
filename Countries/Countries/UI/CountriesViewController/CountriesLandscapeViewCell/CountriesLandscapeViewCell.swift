//
//  CountriesLandscapeViewCell.swift
//  Countries
//
//  Created by Vladimir Budniy on 12/27/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import UIKit

class CountriesLandscapeViewCell: CountryViewCell {
    
    @IBOutlet var countryName:   UILabel?
    @IBOutlet var capitalName:   UILabel?
    @IBOutlet var timezones:     UILabel?
    @IBOutlet var regionName:    UILabel?
    @IBOutlet var populationQty: UILabel?
    @IBOutlet var nativeName:    UILabel?
    @IBOutlet var currencies:    UILabel?

    // MARK: - Public
    
    override func fillWithModel<T: Country>(model: T) {
        self.countryName?.text = model.countryName
        self.capitalName?.text = model.capitalCity
        self.timezones?.text = model.timezones
        self.regionName?.text = model.regionName
        self.nativeName?.text = model.nativeName
        self.currencies?.text = model.currencies
        self.populationQty?.text = model.populationQty.stringFormatedWithSepator
    }
    
}
