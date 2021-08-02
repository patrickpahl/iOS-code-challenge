//
//  MasterViewControllerS.swift
//  ios-code-challenge
//
//  Created by Joe Rocca on 5/31/19.
//  Copyright © 2019 Dustin Lange. All rights reserved.
//

enum ServiceError: Error {
    case Error(error: Error)
    case Other
}

import UIKit

class MasterViewController: UITableViewController {
    
    var detailViewController: DetailViewController?
    var businesses: [Business]?
    var businessCellModels: [BusinessTableViewCellModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BusinessTableViewCell.self, forCellReuseIdentifier: BusinessTableViewCell.identifier)
        
        getBusinesses(atAddress: "5550 West Executive Dr. Tampa, FL 33609") { result in
            switch result {
            case .success(let businesses):
                self.businesses = businesses
                self.createCellModels()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func createCellModels() {
        businessCellModels = []
        guard let businesses = self.businesses else {
            print("No Businesses")
            return
        }
        
        businessCellModels = businesses.map({ BusinessTableViewCellModel(business: $0) })
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func cellModel(index: Int) -> BusinessTableViewCellModel? {
        guard let cellModels = businessCellModels else { return nil }
        
        return cellModels[index]
    }
    
    // yves
    func getBusinesses(atAddress: String, completion: @escaping (Swift.Result<[Business], Error>) -> Void) {
        let urlString = "https://api.yelp.com/v3/businesses/search"
        
        guard var urlComponents = URLComponents(string: urlString) else {
            completion(.failure(ServiceError.Other))
            return
        }
        
        urlComponents.queryItems = [URLQueryItem(name: "location", value: atAddress)]
         
        guard let url = urlComponents.url else {
            completion(.failure(ServiceError.Other))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let apiKey = "3PVvVx4Rt1Ef0oBTZ9DiR2wcU26DNTXwr2c8aB3TAWo0udjmuUo2ksHa07cQc8OD5DKm91N1jvv3s8QUZGGGZElS3a0rpTxu3fKzSWqaLeNHHsQUmONojTU93ikHYXYx"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(ServiceError.Other))
                print("🚨 error: data")
                return
            }
            
            var apiResponse: BusinessesTotal?
            
            do {
                apiResponse = try JSONDecoder().decode(BusinessesTotal.self, from: data)
            } catch {
                completion(.failure(ServiceError.Other))
                print("🚨 error: decoding")
                return
            }
            
            guard let businesses = apiResponse?.businesses else {
                completion(.failure(ServiceError.Other))
                print("🚨 error: unwrap ")
                return
            }
            
            completion(.success(businesses))
            
        }
        task.resume()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController?.isCollapsed ?? false
        super.viewDidAppear(animated)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
//            guard let indexPath = tableView.indexPathForSelectedRow,
//                let controller = segue.destination as? DetailViewController else {
//                return
//            }
//            let object = objects[indexPath.row]
//            controller.setDetailItem(newDetailItem: object)
//            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
//            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }
    
}

extension MasterViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businessCellModels?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BusinessTableViewCell.identifier) as? BusinessTableViewCell,
              let cellModel = cellModel(index: indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.configure(with: cellModel)
        return cell
    }
    
}
