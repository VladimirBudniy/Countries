//
//  CountriesLandscapeViewCell.swift
//  Countries
//
//  Created by Vladimir Budniy on 12/27/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import UIKit

class CountriesLandscapeViewCell: UITableViewCell {
    
    @IBOutlet weak var countrieName: UILabel!
    @IBOutlet weak var capitalName: UILabel!
    @IBOutlet weak var timezones: UILabel!
    
    @IBOutlet weak var regionName: UILabel!
    @IBOutlet weak var populationQty: UILabel!
    @IBOutlet weak var nativeName: UILabel!
    @IBOutlet weak var currencies: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Public
    
    func fillWithObject(object: Country) {
        self.countrieName.text = object.countrieName
        self.capitalName.text = object.capitalCity
        self.timezones.text = object.timezones
        self.regionName.text = object.regionName
        self.nativeName.text = object.nativeName
        self.currencies.text = object.currencies
        self.populationQty.text = object.populationQty.stringFormatedWithSepator
    }
    
}
