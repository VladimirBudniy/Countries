//
//  CountriesPortraitViewCell.swift
//  LoadingView
//
//  Created by Vladimir Budniy on 12/1/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import UIKit

class CountriesPortraitViewCell: CountryViewCell {
    
    @IBOutlet var countrieName: UILabel?
    @IBOutlet var capitalName: UILabel?
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Public
    
    override func fillWithObject(object: Country) {
        self.countrieName?.text = object.countrieName
        self.capitalName?.text = object.capitalCity
    }
    
}
