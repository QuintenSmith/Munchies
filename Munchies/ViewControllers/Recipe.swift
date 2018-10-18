//
//  Recipe.swift
//  Munchies
//
//  Created by Kamil Wrobel on 10/11/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit


class Recipe {
    
    let picture: UIImage
    let recipeTitle: String
    let rating: Int
    var isWished: Bool
    var isFavorite: Bool

    
    init(picture: UIImage, recipeTitle: String, rating: Int, isWished: Bool = false, isFavorite: Bool = false){
        self.picture = picture
        self.recipeTitle = recipeTitle
        self.rating = rating
        self.isWished = isWished
        self.isFavorite = isFavorite
    }
    
}


//MARK: = Recipe model for fetching

struct JSONDictionary: Decodable {
    let results: [fetchedRecipe]
}

struct fetchedRecipe: Decodable {
    let id: Int
    let title: String
    let likes: Int
    let image: String
}


struct DetailedRecipe: Decodable {
    let id: Int
    let title: String
    let readyInMinutes: Int
    let image: String
    //let dishTypes: [String]
    //let cuisines: [String] //not sure
    let instructions : String
    // let analyzedInstructions : []
    let servings: Int?
    let preparationMinutes: Int?
    
}
