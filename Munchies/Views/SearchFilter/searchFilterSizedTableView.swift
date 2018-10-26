//
//  searchFilterSizedTableView.swift
//  Munchies
//
//  Created by Quinten Smith on 10/19/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class searchFilterSizedTableView: UITableView {
    
    //MARK: - Properties
    var maxHeight: CGFloat = UIScreen.main.bounds.size.height
    
    //MARK: - Reload Data
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    
    //MARK: - Settings
    override var intrinsicContentSize: CGSize {
        let height = min(contentSize.height, maxHeight)
        return CGSize(width: contentSize.width, height: height) 
    }
}
