//
//  ImageClassificationController.swift
//  Munchies
//
//  Created by Kamil Wrobel on 10/16/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import Foundation


class imageClassification {
    
    static let shared = imageClassification()
    private init(){}
    
    
    let baseURL = URL(string: "https://api.cloudsight.ai/v1/")
  
    
    
    func postImages(imageData: Data?) {
        
        //prep the url
        guard let url = baseURL else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        
        
        URLSession.uploadTask(<#T##URLSession#>)
        
        
    }
}
