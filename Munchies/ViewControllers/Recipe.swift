//
//  Recipe.swift
//  Munchies
//
//  Created by Kamil Wrobel on 10/11/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

//i think this isnt neede anymore
//this is still used in favorites controller
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
class JSONDictionary: Decodable {
    let results: [fetchedRecipe]
    
    init(results: [fetchedRecipe]){
        self.results = results
    }
}

class fetchedRecipe: Decodable {
    let id: Int
    let title: String
    let likes: Int
    let image: String
    
    init(id: Int, title: String, likes: Int, image: String){
        self.id = id
        self.title = title
        self.likes = likes
        self.image = image
    }
}

class Steps: Decodable {
    let number: Int
    let step: String
    
    init(number: Int, step: String){
        self.number = number
        self.step = step
    }
}

class Instructions: Decodable {
    let name: String
    let steps : [Steps]
    
    init(name: String, steps: [Steps]){
        self.name = name
        self.steps = steps
    }
}

class  extendedIngredients: Decodable {
    let image: String
    let name: String
    let amount: Double
    let unit: String
    let unitShort: String?
    let unitLong:  String?
    let originalString: String
    
    init(image: String, name: String, amount: Double, unit: String, unitShort: String?, unitLong: String?, originalString: String){
        self.image = image
        self.name = name
        self.amount = amount
        self.unit = unit
        self.unitShort = unitShort
        self.unitLong = unitLong
        self.originalString = originalString
    }
}

class DetailedRecipe: Decodable, Equatable {
    static func == (lhs: DetailedRecipe, rhs: DetailedRecipe) -> Bool {
        if lhs.id != rhs.id {return false}
        return true
    }
    
    let id: Int
    let title: String
    let readyInMinutes: Int
    let image: String
    let analyzedInstructions : [Instructions]
    let servings: Int?
    let preparationMinutes: Int?
    let extendedIngredients: [extendedIngredients]?
    let sourceUrl: String?
    
    //those properties are neede for detail view and to assign recipe as favorite - they are not part of the api
    var isFavorite: Bool?
    //add a computed property for image - UIImage doesnt conform to decodable
    //var photo: UIImage?
    
    
    init(id: Int, title: String, readyInMinutes: Int, image: String, analyzedInstructions: [Instructions], servings: Int?, preparationMinutes: Int?, extendedIngredients: [extendedIngredients]?, sourceUrl: String?){
        self.id = id
        self.title = title
        self.readyInMinutes = readyInMinutes
        self.image = image
        self.analyzedInstructions = analyzedInstructions
        self.servings = servings
        self.preparationMinutes = preparationMinutes
        self.extendedIngredients = extendedIngredients
        self.sourceUrl = sourceUrl
    }
    
    
}

class RecipeForDetailView {
    var recipe: DetailedRecipe
    var picture: UIImage?
    
    init(recipe: DetailedRecipe, picture: UIImage?){
        self.recipe = recipe
        self.picture = picture
    }
}


//new structure to replace data source for colectionView in SearcVC, and detail view
//may not work
class RecipeWithDetailAndImage : Equatable{
    
    var detailedRecipe: DetailedRecipe
    var picture: UIImage?
    
    init(detailedRecipe: DetailedRecipe, picture: UIImage?){
        self.detailedRecipe = detailedRecipe
        self.picture = picture
    }
    
    static func == (lhs: RecipeWithDetailAndImage, rhs: RecipeWithDetailAndImage) -> Bool {
        if lhs.detailedRecipe != rhs.detailedRecipe {return false}
        return true
    }
}





