//
//  TestViewCell.swift
//  LoadingView
//
//  Created by Vladimir Budniy on 12/1/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import UIKit

class TestViewCell: UITableViewCell {

    // MARK: - Accessors
    
    @IBOutlet weak var countrieName: UILabel!
    @IBOutlet weak var capitalName: UILabel!
    
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

     // MARK: - Public
    
    func fillWithObject(object: CountrieModel) {
        self.countrieName.text = object.countrieName
        self.capitalName.text = object.capitalCity
    }
    
}
