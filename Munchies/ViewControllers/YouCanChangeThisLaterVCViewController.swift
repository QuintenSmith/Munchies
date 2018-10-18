//
//  YouCanChangeThisLaterVCViewController.swift
//  Munchies
//
//  Created by Quinten Smith on 10/17/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class YouCanChangeThisLaterVCViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        let dataSource = FavoritesCollectionViewDataSource(numberOfItems: 3, recepies: [MockRecpeis])
        collectionView.dataSource = dataSource
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
