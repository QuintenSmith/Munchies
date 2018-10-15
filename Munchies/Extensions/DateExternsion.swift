//
//  DateExternsion.swift
//  Munchies
//
//  Created by Kamil Wrobel on 10/11/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import Foundation

extension Date {
    
    func dateAsString() -> String{
        let formater = DateFormatter()
        formater.dateStyle = .medium
        formater.timeStyle = .short
        return formater.string(from: self)
    }
}
