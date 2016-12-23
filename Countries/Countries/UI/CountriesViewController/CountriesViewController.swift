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
    
    var requestPage = 1
    
    var countries = [Country]()
    
    var tableView: UITableView {
        return self.rootView.tabelView
    }
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addRefreshControl()
        self.registerCellWithIdentifier(identifier: String(describing: CountriesViewCell.self))
        self.load()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Private
    
    private func addRefreshControl() {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshView), for: UIControlEvents.valueChanged)
        self.rootView.tabelView.addSubview(control)
        self.refreshControl = control
    }
    
    @objc private func refreshView() {
        self.requestPage = defaultPage()
        self.load() // need remove all objects from cache
    }
    
    private func defaultPage() -> Int {
        return 1
    }
    
    private func load() {
        NetworkModel.load(page: "1")
        
//        Context.networkRequest(forPage: requestPage.description).startWithResult { result in
//            self.refreshControl!.endRefreshing()
//            self.countries.appendContentsOf(result.value!)
//            self.rootView.tabelView.reloadData()
//        }
    }
    
    private func registerCellWithIdentifier(identifier: String) {
        self.tableView.register(UINib(nibName: identifier, bundle: nil),
                                   forCellReuseIdentifier: identifier)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountriesViewCell.description()) as! CountriesViewCell
        
        cell.fillWithObject(object: self.countries[indexPath.row])
        return cell
        
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let section = tableView.numberOfSections - 1
//        let lastRow = tableView.numberOfRows(inSection: section) - 1
//        
//        if indexPath.row == lastRow {
//            self.requestPage += 1
//            self.load()
//        }
//    }
}
