//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Dandre Ealy on 12/12/16.
//  Copyright © 2016 Dandre Ealy. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var memeObject = Meme()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
          self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func addMeme(_ sender: Any) {
        let createMeme = self.storyboard?.instantiateViewController(withIdentifier: "createMeme") as! ViewController
        self.navigationController?.pushViewController(createMeme, animated: true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ((UIApplication.shared.delegate as? AppDelegate)?.meme.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell", for: indexPath) as? MemeTableCell
       let image = (UIApplication.shared.delegate as? AppDelegate)?.meme[indexPath.row]
        cell?.memeImage.image = image?.memedImage
        let topString = image?.topTextField
        let bottomString = image?.bottomTextField
        let both = "\(topString!) \(bottomString!)"
        cell?.memeTextLabel.text = both
       
        return (cell)!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memeDetail = self.storyboard?.instantiateViewController(withIdentifier: "memeDetail") as! MemeDetailViewController
        memeDetail.meme = (UIApplication.shared.delegate as? AppDelegate)?.meme[indexPath.row]
        self.navigationController?.pushViewController(memeDetail, animated: true)
    }

}
