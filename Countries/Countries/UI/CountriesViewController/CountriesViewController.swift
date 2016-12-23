//
//  TestViewController.swift
//  LoadingView
//
//  Created by Vladimir Budniy on 12/1/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import UIKit
import Alamofire
import ReactiveCocoa
import Result

class TestViewController: UIViewController, ViewControllerRootView, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Accessors
    
    typealias RootViewType = TestView
    
    var refreshControl: UIRefreshControl?
    
    var requestPage = 1
    
    var countries: Array<CountrieModel> = []
    
    var tableView: UITableView {
        return self.rootView.tabelView
    }
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addRefreshControl()
        self.registerCellWithIdentifier(TestViewCell.className())
        self.load()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Private
    
    private func addRefreshControl() {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshView), forControlEvents: UIControlEvents.ValueChanged)
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
        Context.networkRequest(forPage: requestPage.description).startWithResult { result in
            self.refreshControl!.endRefreshing()
            self.countries.appendContentsOf(result.value!)
            self.rootView.tabelView.reloadData()
        }
    }
    
    private func registerCellWithIdentifier(identifier: String) {
        self.tableView.registerNib(UINib(nibName: identifier, bundle: nil),
                                   forCellReuseIdentifier: identifier)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TestViewCell.className()) as! TestViewCell
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView?.backgroundColor = UIColor.clearColor()
        
        cell.fillWithObject(self.countries[indexPath.row])
        return cell
        
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let section = tableView.numberOfSections - 1
        let lastRow = tableView.numberOfRowsInSection(section) - 1
        
        if indexPath.row == lastRow {
            self.requestPage += 1
            self.load()
        }
    }
}
