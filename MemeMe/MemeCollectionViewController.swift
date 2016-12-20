//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Dandre Ealy on 12/12/16.
//  Copyright © 2016 Dandre Ealy. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet weak var flowLayout: UICollectionViewLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var flowLayouts: UICollectionViewFlowLayout!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayouts.minimumInteritemSpacing = space
        flowLayouts.minimumLineSpacing = space
        flowLayouts.itemSize = CGSize(width: dimension, height: dimension)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    @IBAction func addMeme(_ sender: Any) {
        let createMeme = self.storyboard?.instantiateViewController(withIdentifier: "createMeme") as! MemeEditorViewController
        self.navigationController?.pushViewController(createMeme, animated: true)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ((UIApplication.shared.delegate as? AppDelegate)?.meme.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let image = (UIApplication.shared.delegate as? AppDelegate)?.meme[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionCell", for: indexPath) as? MemeCollectionCell
        cell?.memeImage.image = image?.memedImage
        return (cell)!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let memeDetail = self.storyboard?.instantiateViewController(withIdentifier: "memeDetail") as! MemeDetailViewController
        memeDetail.meme = (UIApplication.shared.delegate as? AppDelegate)?.meme[indexPath.row]
        self.navigationController?.pushViewController(memeDetail, animated: true)
    }
    
    
    
}
