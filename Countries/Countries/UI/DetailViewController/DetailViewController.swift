//
//  DetailViewController.swift
//  Countries
//
//  Created by Vladimir Budniy on 1/19/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, ViewControllerRootView, AlertViewController {
    
    // MARK: - Accessors
    
    typealias RootViewType = DetailView
    
    let country: Country
    
    // MARK: - Initializations and Deallocations
    
    init(country: Country) {
        self.country = country
        super.init(nibName: String(describing: DetailViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use init(order:)")
    }
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rootView.showSpinner()
        self.loadCountry()
    }
    
    // MARK: - Private
    
    @objc private func popViewController() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    private func loadError(error: Error) {
        let currentError = error.localizedDescription
        let alertController = alertViewControllerWith(title: "Error",
                                                      message: currentError,
                                                      preferredStyle: UIAlertControllerStyle.alert,
                                                      actionTitle: "Ok",
                                                      style: UIAlertActionStyle.default,
                                                      handler: nil)
        alertController.target(forAction: #selector(popViewController), withSender: nil)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func loadCountry() {
        Country.loadCountry(name: self.country.countrieName!, block: showCountry, errorBlock:loadError)
    }
    
    private func showCountry(country: Country?) {
        self.rootView.fillWithCountry(country: country!)
    }
}
