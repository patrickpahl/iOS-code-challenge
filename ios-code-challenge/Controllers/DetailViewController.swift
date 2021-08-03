//
//  DetailViewController.swift
//  ios-code-challenge
//
//  Created by Joe Rocca on 5/31/19.
//  Copyright © 2019 Dustin Lange. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    lazy private var favoriteBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Star-Outline"), style: .plain, target: self, action: #selector(onFavoriteBarButtonSelected(_:)))

    @objc var detailItem: NSDate?
    var businessModel: BusinessTableViewCellModel?
    //var businessModel: BusinessTableViewCellModel?
    
    private var _favorite: Bool = false
    private var isFavorite: Bool {
        get {
            return _favorite
        } 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        navigationItem.rightBarButtonItems = [favoriteBarButtonItem]
    }
    
    private func configureView() {
        guard let businessModel = businessModel else { return }
        
        nameLabel.text = businessModel.business.name
        categoriesLabel.text = businessModel.categoriesText
        ratingLabel.text = businessModel.ratingText
        reviewCountLabel.text = businessModel.reviewCountText
        priceLabel.text = businessModel.priceText
        imageView.imageFromServerURL(urlString: businessModel.business.image_url)
    }
    
    func setDetailItem(newBusinessModel: BusinessTableViewCellModel, newDetailItem: NSDate) {
        //guard businessModel?.business.name ?? "" != newBusinessModel.business.name else { return }
        guard newDetailItem != detailItem else { return }
        
        detailItem = newDetailItem
        businessModel = newBusinessModel
        configureView()
    }
    
    private func updateFavoriteBarButtonState() {
        favoriteBarButtonItem.image = isFavorite ? UIImage(named: "Star-Filled") : UIImage(named: "Star-Outline")
    }
    
    @objc private func onFavoriteBarButtonSelected(_ sender: Any) {
        _favorite.toggle()
        updateFavoriteBarButtonState()
    }
}
