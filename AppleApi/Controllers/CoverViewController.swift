//
//  CoverViewController.swift
//  AppleApi
//
//  Created by Kevin Waring on 1/7/19.
//  Copyright © 2019 Kevin Waring. All rights reserved.
//

import UIKit

class CoverViewController: UIViewController {

    @IBOutlet weak var simpleLabel: UILabel!
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var searchLabel: UILabel!
    
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    private func setUp() {
        simpleLabel.text = "Kevin's"
        bookLabel.text = "Picks of"
        searchLabel.text = "The Week"
        imageView.image = UIImage(named: "opebBook")
    }
 
    

}
