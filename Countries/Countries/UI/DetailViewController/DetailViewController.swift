//
//  DetailViewController.swift
//  Countries
//
//  Created by Vladimir Budniy on 1/19/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class DetailViewController: UIViewController, ViewControllerRootView, AlertViewController {
    
    // MARK: - Accessors
    
    typealias RootViewType = DetailView
    
    let countryName: String
    
    // MARK: - Initializations and Deallocations
    
    init(countryName: String) {
        self.countryName = countryName
        super.init(nibName: String(describing: DetailViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use init(order:)")
    }
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rootView.showSpinner()
        self.load()
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
                                                      handler:({(alert: UIAlertAction!) in self.popViewController()}))
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func load() {
        if let url = Country.urlFor(country: self.countryName) {
            loadWith(url: url)
                .observe(on: UIScheduler())
                .startWithResult({ [weak self] result in
                switch result {
                case .success:
                    self?.showCountry(country: result.value)
                case let .failure(error):
                    self?.loadError(error: error)
                }
            })
        }
    }
    
    private func showCountry(country: [Country]?) {
        if let country = country {
            self.rootView.fillWithCountry(country: country.first!)
        }
    }
}
