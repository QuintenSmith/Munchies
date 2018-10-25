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
    
    //properties for query items from profilePage
    var diet: String = ""
    // var intolerance: String = ""
    var intolerances = Set<String>()
    //var userIntolerances = Set<intolerances>()

    
    
    //initial fetch
    var recipes: [fetchedRecipe] = []
    //second fetch with more details
    var recipiesWithDetail: [DetailedRecipe] = []
    //filtered locally on the device - time it takes to cook, portions
    
    
    var filteredRecipies: [DetailedRecipe] = []
    // container to store a recipy to be displayed in the detail view
    var recipeForDetailView : RecipeForDetailView?
    //recipies that are marked as favorite
    var favoriteRecipies = [RecipeWithDetailAndImage]()
    
    
    //this should have the same recipies as filtered recipies, but with image now
    var filteredRecipiesWithDetailAndImage = [RecipeWithDetailAndImage]()
    var temporaryInstructionStorage = [Instructions]()
    var temporaryWebUrlForWebView : String = ""
    
    
    func removefromFavorites(recipe: RecipeWithDetailAndImage){
        guard let index = favoriteRecipies.index(of: recipe) else {return}
        favoriteRecipies.remove(at: index)
    }
    
    
    
    //random joke
    var randomJoke : String = "Remember: You can eat your way out of almost any problem."
    
    //MARK: - Base URLs
    //url for fetching recipies
    private let baseURLString = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/searchComplex"
    //url for fetching detiled recipies
    private let baseURLStringFroDetiledRecipe = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/informationBulk"
    //url for random food joke
    private let baseURLStringForRandomJoke = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/food/jokes/random"
    
    
    
    //MARK: - Fetch recipies by ingredients
    func searchRecipiesBy(ingredients: String, completion: @escaping ([fetchedRecipe]?) -> Void) {
        
        guard let baseUrl = URL(string: baseURLString) else {
            fatalError("❌ Bad base URL for first recipe search")
        }
        
        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
        
        var querryComponents: [URLQueryItem] = []
        
        //MARK: - Query Items:
        
        if !intolerances.isEmpty {
            let intoleranceQuery = URLQueryItem(name: "intolerances", value: intolerancesAsString())
            querryComponents.append(intoleranceQuery)
            print("👻👻👻 \(intoleranceQuery)")
        }
        if diet != "" {
            let dietQuery = URLQueryItem(name: "diet", value: diet)
            querryComponents.append(dietQuery)
        }
        
        let ingredientAmoutQuery = URLQueryItem(name: "number", value: "\(100)")
        querryComponents.append(ingredientAmoutQuery)
        
        let instructionQuery = URLQueryItem(name: "instructionsRequired", value: "true")
        querryComponents.append(instructionQuery)
        
        let ingredientQuery = URLQueryItem(name: "includeIngredients", value: ingredients)
        querryComponents.append(ingredientQuery)
        
        //to add this we need to add button on the "SearchFilterVC" and set those values there
        //let typeQuery = URLQueryItem(name: "type", value: "side dish")
        //let cuisine = URLQueryItem(name: "cuisine", value: "american")
        
        //Add Queries to components
        components?.queryItems = querryComponents
        
        guard let url = components?.url else {completion(nil); return}
        
        //Add Header Files
        var request = URLRequest(url: url)
        request.addValue(getApiKey(named: "X-Mashape-Key"), forHTTPHeaderField: "X-Mashape-Key")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        print("🐷🐷🐷 Original URL: \n \(url)")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("❌ There was an error fetching from datatask: \(error) \(error.localizedDescription)")
                completion([]); return
            }
            
            //            if let response = response {
            //                print("➡️ Server Response: \(response)")
            //            }
            
            guard let data = data else {
                print("❌ No data returned")
                completion([]); return
            }
            
            do {
                let jsonDictionary = try JSONDecoder().decode(JSONDictionary.self, from: data)
                let recipes = jsonDictionary.results.compactMap({$0})
                completion(recipes)
            } catch let error {
                print("❌ There was an error decoding from jsonDictionary: \(error) \(error.localizedDescription)")
                completion([]); return
            }
            }.resume()
    }
    
    
    //MARK: - Fetch detiled Recipies
    func fetchDetailedRecipies(ids: [Int], completion: @escaping ([DetailedRecipe]?)-> Void) {
        guard let baseURL = URL(string: baseURLStringFroDetiledRecipe) else {
            fatalError("❌ bad base url for detailed Recipe")
        }
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        //converts int array to string, and joins them together
        let idsAsString = ids.compactMap({String($0)}).joined(separator: ",")
        let idQueries = URLQueryItem(name: "ids", value: idsAsString)
        
        components?.queryItems = [idQueries]
        
        guard let url = components?.url else {
            print("❌ error putting url together with components")
            completion([])
            return
        }
        print("☢️🖖 detail URL: \n \(url)")
        var request = URLRequest(url: url)
        
        request.addValue(getApiKey(named: "X-Mashape-Key"), forHTTPHeaderField: "X-Mashape-Key")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("❌ Error during URL Session \(error.localizedDescription)")
                completion([])
                return
            }
            //            if let response = response {
            //                print("➡️ Server Response: \(response)")
            //            }
            guard let data = data else {
                print("❌ Error: No Data returned from url session on detail recipie")
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
                print("❌ There was an error on \(#function): \(error) \(error.localizedDescription)")
                completion([])
            }
            }.resume()
    }
    
    
    //MARK: - Fetch images for Recipies
    func fetchImage(at URLString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: URLString) else {completion(nil); return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("❌ There was an error fetching Images from datasource \(#function) \(error) \(error.localizedDescription)")
                completion(nil)
                return }
            
            //            if let response = response {
            //                print("➡️ Server Response: \(response)")
            //            }
            guard let data = data, let image = UIImage(data: data) else {completion(nil); return}
            completion(image)
            }.resume()
    }
    
    //MARK: - Filter Recipies by time it take to make them
    func filterRecipiesByTimeItTakesToMakeIt(arrayOfRecipies: [DetailedRecipe], timeItShouldTake: Int?, servingAmount: Int?, completion: @escaping (Bool)-> Void) {
        
        if timeItShouldTake != nil && servingAmount == nil {
            guard let time = timeItShouldTake else {return}
            for recipe in recipiesWithDetail {
                if recipe.readyInMinutes <= time {
                    filteredRecipies.append(recipe)
                    print("Ready in min: \(recipe.readyInMinutes) \n Servings: notSpecified")
                }
            }
            
        } else if servingAmount != nil && timeItShouldTake == nil {
            guard let servings = servingAmount else {return}
            for recipe in recipiesWithDetail {
                if  recipe.servings == servings {
                    filteredRecipies.append(recipe)
                    print("Ready in min: notSpecified \n Servings: \(servings)")
                }
            }
            
        } else if servingAmount != nil && timeItShouldTake != nil {
            guard let time = timeItShouldTake,
                let servings = servingAmount else {return}
            for recipe in recipiesWithDetail {
                if recipe.readyInMinutes <= time && recipe.servings == servings{
                    filteredRecipies.append(recipe)
                    print("Ready in min: \(time) \n Servings: \(servings)")
                }
            }
        } else {
            for recipe in recipiesWithDetail {
                    filteredRecipies.append(recipe)
                    print("no time and serving specified")
            }
                    }
        
        //image fetch goes into dispatch group to eliminate condition where collection view would load before images were fetch
        let dispatchGroup = DispatchGroup()
        for recipe in filteredRecipies {
            //MARK: - Fetch Images Call
            if let image = recipe.image {
                dispatchGroup.enter()
                fetchImage(at: image) { (image) in
                    let detailedRecipe = RecipeWithDetailAndImage.init(detailedRecipe: recipe, picture: image)
                    self.filteredRecipiesWithDetailAndImage.append(detailedRecipe)
                    print("🚀 image fetched and apended")
                    dispatchGroup.leave()
                }
            }
            print("finished fetching images")
        }
        //onec its done with all the fetchin in dispatch group, it calls the complepiton
        dispatchGroup.notify(queue: .main) {
            print("Calling Completion Now")
            completion(true)
        }
    }
    
    //MARK: - Fetch random food fact
    func fetchRandomJoke(completion: @escaping(Bool) -> Void) {
        guard let baseURL = URL(string: baseURLStringForRandomJoke) else {
            fatalError("❌ bad base url for detailed Recipe")
        }
        var request = URLRequest(url: baseURL)
        
        request.addValue(getApiKey(named: "X-Mashape-Key"), forHTTPHeaderField: "X-Mashape-Key")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("❌ Error during URL Session \(error.localizedDescription)")
                completion(false)
                return
            }
            //            if let response = response {
            //                print("➡️ Server Response: \(response)")
            //            }
            guard let data = data else {
                print("❌ Error: No Data returned from url session on random joke")
                completion(false)
                return
            }
            do{
                let randomFoodJoke = try JSONDecoder().decode(RandomJoke.self, from: data)
                self.randomJoke = randomFoodJoke.text
                completion(true)
            }catch {
                print("❌ There was an error on \(#function): \(error) \(error.localizedDescription)")
                completion(false)
            }
            }.resume()
    }
    
    
    //MARK: - Getting the ApiKey
    func getApiKey(named keyname: String) -> String {
        guard let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist") else {
            fatalError("❌ No File Path to API KEY")}
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: keyname) as? String else {
            print("❌ Cannot cast the value of API key to String")
            return ""}
        return value
    }
    
    //MARK: - Turns Intolerances Set to Stirng
    func intolerancesAsString() -> String{
        return intolerances.joined(separator: ", ")
    }
    
}


