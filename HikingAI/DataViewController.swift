//
//  DataViewController.swift
//  HikingAI
//
//  Created by Yaroslav Spirin on 16/11/2019.
//  Copyright © 2019 Yaroslav Spirin. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {
    
    @IBOutlet weak var parkImageView: UIImageView!
    var index: Int!
    var imagePath: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parkImageView.layer.cornerRadius = 10.0
        parkImageView.image = UIImage(named: imagePath)
    }
}
