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
        table.backgroundColor = .lightGray
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.estimatedRowHeight = 160
        table.rowHeight = UITableView.automaticDimension
        table.register(CountryDetailCell.self, forCellReuseIdentifier: "countryDetailsCell")
        table.dataSource = self
        table.delegate = self
        return table
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
        self.navigationController?.navigationBar.barTintColor = .blue
     self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func prepareViewModelObserver() {
        self.viewModel.countryValueDidChanges = { (finished, countryName) in
                self.reloadTableView(countryName: countryName)
        }
    }
    
    private func reloadTableView(countryName: String) {
        DispatchQueue.main.async {
            self.navigationItem.title = countryName
            self.countryDetailsTableview.reloadData()
        }
    }


}
//MARK:- Prepare UI
extension HomeViewController {
    
    func prepareUI() {
        setUpNavigation()
        prepareTableView()
        prepareViewModelObserver()
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
