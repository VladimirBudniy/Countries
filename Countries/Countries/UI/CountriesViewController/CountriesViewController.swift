//
//  CountriesViewController.swift
//  LoadingView
//
//  Created by Vladimir Budniy on 12/1/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController, ViewControllerRootView, AlertViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Accessors
    
    typealias RootViewType = CountriesView
    
    let identifier = String(describing: CountriesPortraitViewCell.self)
    
    var requestPage = 1
    
    var countries: [Country]?
    
    var tableView: UITableView? {
        return self.rootView.tabelView
    }
    
    // MARK: - Initializations and Deallocations
    
    init() {
        self.countries = []
        super.init(nibName: String(describing: CountriesViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use init(order:)")
    }
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addRefreshControl()
        self.registerCellWith(identifier: self.identifier)
        self.loadCounties()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier) as! CountryViewCell
        cell.fillWithObject(object: (self.countries?[indexPath.row])!)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        let controller = DetailViewController(country: (self.countries?[indexPath.row])!)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let section = tableView.numberOfSections - 1
        let lastRow = tableView.numberOfRows(inSection: section) - 1
        
        if indexPath.row == lastRow {
            self.requestPage += 1
            self.loadCounties(forPage: self.requestPage, primaryLoad: false)
        }
    }
    
    // MARK: - Private
    
    private func addRefreshControl() {
        let control = UIRefreshControl()
        control.attributedTitle = NSAttributedString(string: "Pull to refersh")
        control.addTarget(self, action: #selector(refreshView), for: UIControlEvents.valueChanged)
        self.tableView?.refreshControl = control
    }
    
    @objc private func refreshView() {
        self.loadCounties()
    }
    
    private func addObjects(objects: [Country]?) {
        if let array = objects {
            self.countries?.append(contentsOf: array)
            let tableView = self.tableView
            tableView?.refreshControl?.endRefreshing()
            tableView?.reloadData()
        }
    }
    
    private func loadError(error: Error) {
        self.tableView?.refreshControl?.endRefreshing()
        let currentError = error.localizedDescription
        
        
        let alertController = alertViewControllerWith(title: "Error",
                                                      message: currentError,
                                                      preferredStyle: UIAlertControllerStyle.alert,
                                                      actionTitle: "Ok",
                                                      style: UIAlertActionStyle.default,
                                                      handler: nil)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func loadCounties(forPage: Int = 1, primaryLoad: Bool = true) {
        if primaryLoad == true {
            DatabaseController.sharedInstance.deleteAll()
            self.countries?.removeAll()
            self.tableView?.reloadData()
        }
        
        let stringPage = String(forPage)
        Country.load(page:stringPage, block: addObjects, errorBlock:loadError)
    }

    private func registerCellWith(identifier: String) {
        self.tableView?.register(UINib(nibName: identifier, bundle: nil),
                                 forCellReuseIdentifier: identifier)
    }
}
