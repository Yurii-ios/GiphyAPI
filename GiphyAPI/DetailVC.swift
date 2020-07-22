//
//  ViewController.swift
//  GiphyAPI
//
//  Created by Yurii Sameliuk on 21/07/2020.
//  Copyright © 2020 Yurii Sameliuk. All rights reserved.
//
import SDWebImage
import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet var gifImageView: UIImageView!
    
    var gif: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gifImageView.image = self.gif
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
}

