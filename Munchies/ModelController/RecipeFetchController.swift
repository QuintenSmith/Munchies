//
//  RecipeFetchController.swift
//  Munchies
//
//  Created by Kamil Wrobel on 10/17/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import Foundation


class RecipeFetchController {
    
    //MARK: - Singelton
    static let shared = RecipeFetchController()
    private init () {}
    
    
    //MARK: - Properties
    //initial fetch
    var recipes: [fetchedRecipe] = []
    //second fetch with more details
    var recipiesWithDetail: [DetailedRecipe] = []
    //filtered locally on the device - time it takes to cook, portions
    var filteredRecipies: [DetailedRecipe] = []
    
    //MARK: - Base URLs
    //url for fetching recipies
    private let baseURLString = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/searchComplex"
    //url for fetching detiled recipies
    private let baseURLStringFroDetiledRecipe = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/informationBulk"
    
    
    //MARK: - Fetch recipies by ingredients
    func searchRecipiesBy(ingredients: String, completion: @escaping ([fetchedRecipe]?) -> Void) {
        
        guard let baseUrl = URL(string: baseURLString) else {
            fatalError("Bad URL")
        }
        
        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
        
        //Query Items:
        //FIXME: the queries needs to came in from user profile
    #warning ("the queries needs to came in from user profile")
        let cuisine = URLQueryItem(name: "cuisine", value: "american")
        let intolerance = URLQueryItem(name: "intolerances", value: "peanut, shellfish, soy")
        let instructionsRequired = URLQueryItem(name: "instructionsRequired", value: "true")
        let ingredientQuery = URLQueryItem(name: "includeIngredients", value: ingredients)
        let typeQuery = URLQueryItem(name: "type", value: "side dish")
        let dietQuery = URLQueryItem(name: "diet", value: "vegan")
        
        //Add Queries to components
        components?.queryItems = [cuisine, intolerance, instructionsRequired, ingredientQuery]
        
        guard let url = components?.url else {completion(nil); return}
        
        //Add Header Files
        var request = URLRequest(url: url)
    //#error ("need to remove this before uploading to github")
        request.addValue("", forHTTPHeaderField: "X-Mashape-Key")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        print("🐷🐷🐷 \(url)")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("There was an error fetching from datatask: \(error) \(error.localizedDescription)")
                completion([]); return
            }
            
            if let response = response {
                print("Server Response: \(response)")
            }
            
            guard let data = data else {
                print("No data returned")
                completion([]); return
            }
            
            do {
                let jsonDictionary = try JSONDecoder().decode(JSONDictionary.self, from: data)
                let recipes = jsonDictionary.results.compactMap({$0})
                completion(recipes)
            } catch let error {
                print("There was an error decoding from jsonDictionary: \(error) \(error.localizedDescription)")
                completion([]); return
            }
            }.resume()
    }
    
    
    //MARK: - Fetch detiled Recipies
    func fetchDetailedRecipies(ids: [Int], completion: @escaping ([DetailedRecipe]?)-> Void) {
        
        guard let baseURL = URL(string: baseURLStringFroDetiledRecipe) else {
            fatalError("bad base url for detailed Recipe")
        }
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        //converts int array to string, and joins them together
        let idsAsString = ids.compactMap({String($0)}).joined(separator: ",")
        
        let idQueries = URLQueryItem(name: "ids", value: idsAsString)
        
        components?.queryItems = [idQueries]
        
        guard let url = components?.url else {
            print("error putting url together with components")
            completion([])
            return
        }
        
        print("☢️🖖\(url)")
        
        var request = URLRequest(url: url)
        
        
        request.addValue("", forHTTPHeaderField: "X-Mashape-Key")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error during URL Session")
                completion([])
                return
            }
            
            if let response = response {
                print("Server Response: \(response)")
            }
            
            guard let data = data else {
                print("❌Error: No Data returned from url session on detail recipie")
                completion([])
                return
            }
            
            //decode Data
            do{
                let detailedRecipies = try JSONDecoder().decode([DetailedRecipe].self, from: data)
                let detailedRecipiesMaped = detailedRecipies.compactMap({$0})
                self.recipiesWithDetail = detailedRecipiesMaped
                completion(detailedRecipiesMaped)
            }catch {
                print("There was an error on \(#function): \(error) \(error.localizedDescription)")
                completion([])
            }
            
            
            }.resume()
    }
    
    
    //MARK: - Fetch images for Recipies
    func fetchImage(at URLString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: URLString) else {completion(nil); return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("There was an error fetching Images from datasource \(#function) \(error) \(error.localizedDescription)")
                completion(nil)
                return }
            
            if let response = response {
                print("Server Response: \(response)")
            }
            
            guard let data = data, let image = UIImage(data: data) else {completion(nil); return}
            completion(image)
            }.resume()
        
    }
    
    
    //Filter Recipies by time it take to make them
    func filterRecipiesByTimeItTakesToMakeIt(arrayOfRecipies: [DetailedRecipe], timeItShouldTake: Int) {
        for recipe in recipiesWithDetail {
            if recipe.readyInMinutes <= timeItShouldTake {
                filteredRecipies.append(recipe)
            }
        }
        
    }
    
    
    //MARK: - Fetch random foor fact
    func
    
    
}
