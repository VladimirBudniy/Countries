//
//  CountryDetailViewController.swift
//  Countries
//
//  Created by Vladimir Budniy on 12/28/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import UIKit

class CountryDetailViewController: UIViewController, ViewControllerRootView, UITableViewDataSource, UITableViewDelegate {
    
    typealias RootViewType = CountryDetailView
    
    var refreshControl: UIRefreshControl?
    
    var requestPage = 1
    
    var countries: Array<Country>?
    
    var tableView: UITableView {
        return self.rootView.tabelView
    }
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.countries = DatabaseController.fetchEntity(type: Country.self)
        self.registerCellWithIdentifier(identifier: String(describing: CountriesLandscapeViewCell.self))
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isPortrait {
            _ = self.navigationController?.popViewController(animated: true)
            print("Portrait")
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CountriesLandscapeViewCell.self)) as! CountriesLandscapeViewCell
        cell.fillWithObject(object: (self.countries?[indexPath.row])!)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
    // MARK: - Private
    
    private func registerCellWithIdentifier(identifier: String) {
        self.tableView.register(UINib(nibName: identifier, bundle: nil),
                                forCellReuseIdentifier: identifier)
    }
}
