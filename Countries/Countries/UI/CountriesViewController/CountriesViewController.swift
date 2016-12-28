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
    
    var refreshControl: UIRefreshControl?

    var landscapeOrientation: Bool = false
    
    var countries: Array<Country>?
    
    var tableView: UITableView {
        return self.rootView.tabelView
    }
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addRefreshControl()
        self.registerCellWithIdentifier(identifier: String(describing: CountriesPortraitViewCell.self))
        self.registerCellWithIdentifier(identifier: String(describing: CountriesLandscapeViewCell.self))
        self.loadCounties()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            self.landscapeOrientation = true
            self.tableView.rowHeight = 70
            self.tableView.reloadData()
            print("Landscape")
        } else {
            self.landscapeOrientation = false
            self.tableView.rowHeight = 44
            self.tableView.reloadData()
            print("Portrait")
        }
    }

    
    // MARK: - Private
    
    private func addRefreshControl() {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshView), for: UIControlEvents.valueChanged)
        self.rootView.tabelView.addSubview(control)
        self.refreshControl = control
    }
    
    @objc private func refreshView() {
        self.loadCounties()
        self.refreshControl?.endRefreshing()
    }
    
    private func addObjects(objects: Array<Country>) {
        self.countries = objects
        self.tableView.reloadData()
    }

    private func loadCounties() {
        DatabaseController.deleteAll(entityType: Country.self)
        NetworkModel.loadCountries(block: addObjects)
    }
    
    private func registerCellWithIdentifier(identifier: String) {
        self.tableView.register(UINib(nibName: identifier, bundle: nil),
                                   forCellReuseIdentifier: identifier)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.landscapeOrientation == true {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CountriesLandscapeViewCell.self)) as! CountriesLandscapeViewCell
            cell.fillWithObject(object: (self.countries?[indexPath.row])!)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CountriesPortraitViewCell.self)) as! CountriesPortraitViewCell
            cell.fillWithObject(object: (self.countries?[indexPath.row])!)
            
            return cell
        }
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
}
