//
//  AppleDetailViewController.swift
//  AppleApi
//
//  Created by Kevin Waring on 12/28/18.
//  Copyright © 2018 Kevin Waring. All rights reserved.
//

import UIKit

class AppleDetailViewController: UIViewController {
    public var result: Result!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var kindLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateEventUI()
        
    }
    private func updateEventUI() {
        title = result.trackName
        
        if let rating = result.averageUserRating{
            ratingLabel.text = "Rating: \(rating)"
        }else{
           ratingLabel.text =  "n/a"
        }

        if let price = result.price {
            priceLabel.text = "Price: \(price)"
        }else {
            priceLabel.text = "n/a"
        }
//
        nameLabel.text = result.trackName
        textView.text = result.description
        releaseDateLabel.text = result.releaseDate
        kindLabel.text = result.kind
        //ratingLabel.text = "Rating: \(result.averageUserRating)"
        //priceLabel.text = "Price: $\(result.price)"
        
        
        
    }
    
    
    
    
}

    



