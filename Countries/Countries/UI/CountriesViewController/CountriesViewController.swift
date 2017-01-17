//
//  CountriesViewController.swift
//  LoadingView
//
//  Created by Vladimir Budniy on 12/1/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController, ViewControllerRootView, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Accessors
    
    typealias RootViewType = CountriesView
    
    var countries: [Country]?
    
    var tableView: UITableView? {
        return self.rootView.tabelView
    }
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addRefreshControl()
        self.registerCellsWith(identifiers: [String(describing: CountriesPortraitViewCell.self),
                                             String(describing: CountriesLandscapeViewCell.self)])
        self.loadCounties()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            self.tableView?.rowHeight = 70
            print("Landscape")
        } else {
            self.tableView?.rowHeight = 44
            print("Portrait")
        }
        
        self.tableView?.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.indentifierFor(orientation: UIDevice.current.orientation)) as! CountryViewCell
        cell.fillWithObject(object: (self.countries?[indexPath.row])!)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
    // MARK: - Private
    
    private func addRefreshControl() {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshView), for: UIControlEvents.valueChanged)
        self.tableView?.refreshControl = control
    }
    
    @objc private func refreshView() {
        self.loadCounties()
    }
    
    private func addObjects(objects: [Country]?) {
        self.countries = objects
        self.tableView?.refreshControl?.endRefreshing()
        self.tableView?.reloadData()
    }
    
    private func loadCounties() {
        DatabaseController.sharedInstance.deleteAll(entityType: Country.self)
        loadCountries(block: addObjects)
    }
    
    private func registerCellsWith(identifiers: [String]) {
        for nibName in identifiers {
            self.tableView?.register(UINib(nibName: nibName, bundle: nil),
                                     forCellReuseIdentifier: nibName)
        }
    }
    
    private func indentifierFor(orientation: UIDeviceOrientation) -> String {
        switch orientation {
        case .landscapeLeft, .landscapeRight:
            return String(describing: CountriesLandscapeViewCell.self)
        default:
            return String(describing: CountriesPortraitViewCell.self)
        }
    }
}
