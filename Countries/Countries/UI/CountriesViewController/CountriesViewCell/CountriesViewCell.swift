//
//  CountriesViewCell.swift
//  LoadingView
//
//  Created by Vladimir Budniy on 12/1/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import UIKit

class CountriesViewCell: UITableViewCell {

    // MARK: - Accessors
    
    @IBOutlet weak var countrieName: UILabel!
    @IBOutlet weak var capitalName: UILabel!
    
    
    // MARK: - Initialization
    
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
    }
    
}
