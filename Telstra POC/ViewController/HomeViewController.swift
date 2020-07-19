//
//  CountryDetailsViewController.swift
//  Telstra POC
//
//  Created by Ravi Kumar Yaganti on 18/07/20.
//  Copyright © 2020 RK. All rights reserved.
//

import UIKit
import Reachability

class HomeViewController: UIViewController {
    
    //MARK: Internal Properties
    
    lazy var countryDetailsTableview: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.estimatedRowHeight = 160
        table.rowHeight = UITableView.automaticDimension
        table.register(CountryDetailCell.self, forCellReuseIdentifier: "countryDetailsCell")
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.tintColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        refresh.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresh.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        return refresh
    }()
    
    let viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        viewModel.fetchData()
    }
    
}

//MARK:- Private Methods
extension HomeViewController {
    
    private func setUpNavigation() {
        navigationItem.title = ""
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.7254902124, green: 0.3861529063, blue: 0.056381469, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func prepareViewModelObserver() {
        self.viewModel.countryValueDidChanges = { (finished, countryName) in
                self.navigationItem.title = countryName
                self.reloadTableView()
        }
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.countryDetailsTableview.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    private func setupRefereshData() {
        countryDetailsTableview.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        if Connectivity.sharedInstance.isReachable{
            viewModel.fetchData()
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.refreshControl.endRefreshing()
            }
            self.showNetworkAlert()

        }
    }

    private func showNetworkAlert(){
        self.showAlert(title: Constants.NETWORK_ERROR_ALERT_TITLE, message: Constants.NETWORK_ERROR_ALERT_MESSAGE)
    }

}
//MARK:- Prepare UI
extension HomeViewController {
    
    func prepareUI() {
        setUpNavigation()
        prepareTableView()
        prepareViewModelObserver()
        setupRefereshData()
    }
    
    func prepareTableView() {
        view.addSubview(countryDetailsTableview)
//        countryDetailsTableview.translatesAutoresizingMaskIntoConstraints = false
        countryDetailsTableview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        countryDetailsTableview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        countryDetailsTableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        countryDetailsTableview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true    }
}

// MARK: - UITableView Delegate And Datasource Methods

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.country?.details?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryDetailsCell", for: indexPath) as! CountryDetailCell
        let items = viewModel.country?.details![indexPath.row]
       cell.countryDetails = items
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
        
}
