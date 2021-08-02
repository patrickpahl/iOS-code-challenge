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
    
    lazy private var dataSource: NXTDataSource? = {
        guard let dataSource = NXTDataSource(objects: nil) else { return nil }
        dataSource.tableViewDidReceiveData = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.tableView.reloadData()
        }
        return dataSource
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        getBusinesses(atAddress: "5550 West Executive Dr. Tampa, FL 33609") { result in
            switch result {
            case .success(let businsses):
                for business in businsses {
                    print(business.name)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
//        let query = YLPSearchQuery(location: "5550 West Executive Dr. Tampa, FL 33609")
//        AFYelpAPIClient.shared().search(with: query, completionHandler: { [weak self] (searchResult, error) in
//            guard let strongSelf = self,
//                let dataSource = strongSelf.dataSource,
//                let businesses = searchResult?.businesses else {
//                    return
//            }
//            dataSource.setObjects(businesses)
//            strongSelf.tableView.reloadData()
//        })
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
            
            data.printJSON()
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
