//
//  ImageClasificationController.swift
//  Munchies
//
//  Created by Kamil Wrobel on 10/20/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import Foundation


class ImageClasificationController {
    
    static let shared = ImageClasificationController()
    private init() {}
    
    var clasifications = [String]()
    
    
    var curentImageAndClasification : UIImage?
    
    //MARK: - Helper method to turn array into sting
    func clasificationsAsString() -> String{
        return clasifications.joined(separator: ", ")
    }
    
}
