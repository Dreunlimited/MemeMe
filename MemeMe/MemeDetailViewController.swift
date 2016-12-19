//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Dandre Ealy on 12/16/16.
//  Copyright © 2016 Dandre Ealy. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    @IBOutlet weak var memedImage: UIImageView!
    var meme: Meme!
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
           self.tabBarController?.tabBar.isHidden = true
         self.memedImage.image = meme.memedImage
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

}
