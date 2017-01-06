//
//  CountriesLandscapeViewCell.swift
//  Countries
//
//  Created by Vladimir Budniy on 12/27/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import UIKit

class CountriesLandscapeViewCell: CountryViewCell {
    
    @IBOutlet var countrieName: UILabel?
    @IBOutlet var capitalName: UILabel?
    @IBOutlet var timezones: UILabel?
    
    @IBOutlet var regionName: UILabel?
    @IBOutlet var populationQty: UILabel?
    @IBOutlet var nativeName: UILabel?
    @IBOutlet var currencies: UILabel?

    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Public
    
    override func fillWithObject(object: Country) {
        self.countrieName?.text = object.countrieName
        self.capitalName?.text = object.capitalCity
        self.timezones?.text = object.timezones
        self.regionName?.text = object.regionName
        self.nativeName?.text = object.nativeName
        self.currencies?.text = object.currencies
        self.populationQty?.text = object.populationQty.stringFormatedWithSepator
    }
    
}
