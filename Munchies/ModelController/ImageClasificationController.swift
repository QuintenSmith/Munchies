//
//  ImageClasificationController.swift
//  Munchies
//
//  Created by Kamil Wrobel on 10/20/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import Foundation


class ImageClasificationController {
    
    //MARK: - Singelton
    static let shared = ImageClasificationController()
    private init() {}
    
    
    //MARK: - Properties
    var clasifications = [String]()
    var curentImageAndClasification : UIImage?
    
    
    //MARK: - Helper method to turn array into sting
    func clasificationsAsString() -> String{
        return clasifications.joined(separator: ", ")
    }
    
}
