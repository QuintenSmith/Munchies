//
//  SearchFilterVC.swift
//  Munchies
//
//  Created by Quinten Smith on 10/17/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit
import CloudSight

class SearchFilterVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDelegate, UITableViewDataSource, CloudSightQueryDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    //not connected
    @IBOutlet weak var imageToBeClasified: UIImageView!
    @IBOutlet weak var viewToShowClasification: UIView!
    
    
    
    //MARK: - Properties
    var count: Int = 0
    var curentTagButtonTime: Int = 60
    var portionSize: Int = 2
    var currentClassificationText: String = ""
    var cloudSightQuery : CloudSightQuery!
    //This is temporary ingredient list - its gone have to be moved to model controller for proper MVC
    var ingredientListFromCamera = [String]()
    
    
    //MARK: - LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        //imageToBeClasified.isHidden = true
        //pops the camera on initial load
        if  UIImagePickerController.isSourceTypeAvailable(.camera) {
            presentCamera(sourceType: .camera)
        }
        
        //MARK: - Gets Api Key and assigns it.
        CloudSightConnection.sharedInstance().consumerKey = RecipeFetchController.shared.getApiKey(named: "cloudSightKey")
        CloudSightConnection.sharedInstance().consumerSecret = RecipeFetchController.shared.getApiKey(named: "cloudSightSecret")
    }
    
    
    //MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as? SearchFilterIngredientTableViewCell
        cell?.ingredientCell.text = "O  Ingredient \(indexPath.row+1)"
        return cell ?? UITableViewCell()
    }
    
    
    //MARK: - Actions
    @IBAction func timeButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            curentTagButtonTime = 15
            print(curentTagButtonTime)
        case 1:
            curentTagButtonTime = 30
            print(curentTagButtonTime)
        case 2:
            curentTagButtonTime = 60
            print(curentTagButtonTime)
        case 3:
            curentTagButtonTime = 90
            print(curentTagButtonTime)
        case 4:
            curentTagButtonTime = 400
            print(curentTagButtonTime)
        default:
            curentTagButtonTime = 60
            print(curentTagButtonTime)
            
        }
    }
    
    
    @IBAction func portionButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            portionSize = 1
        case 1:
            portionSize = 2
        case 2:
            portionSize = 4
        case 3:
            portionSize = 6
        case 4:
            portionSize = 8
        case 5:
            portionSize = 10
        default:
            portionSize = 2
        }
    }
    
    @IBAction func findButtonTapped(_ sender: Any) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        //display random food joke
        //        print("🤩fetching joke")
        //        RecipeFetchController.shared.fetchRandomJoke { (success) in
        //            if success {
        //                let alert = UIAlertController(title: "Loading Results", message: RecipeFetchController.shared.randomJoke, preferredStyle: .alert)
        //                alert.addAction(UIAlertAction(title: "Haha", style: .cancel, handler: nil))
        //                print("😂presenting joke")
        //                self.present(alert, animated: true)
        //            }
        //        }
        
        print("🤩fetching recipes")
        //run fetch functions
        #warning ("replace the ingredients with this: convertIngredientArrayToString()")
        RecipeFetchController.shared.searchRecipiesBy(ingredients: RecipeFetchController.shared.temporatyIngredients ) { (recipes) in
            print("✅ Finished fetching recipies")
            guard let recipes = recipes else {return}
            RecipeFetchController.shared.recipes = recipes
            
            var arrayOfRecipeIds = [Int]()
            for recipe in RecipeFetchController.shared.recipes {
                arrayOfRecipeIds.append(recipe.id)
            }
            
            print("🤩 fetching detailed recipies")
            RecipeFetchController.shared.fetchDetailedRecipies(ids: arrayOfRecipeIds, completion: { (detailedRecipies) in
                guard let detailedRecipies = detailedRecipies else {return}
                RecipeFetchController.shared.recipiesWithDetail = detailedRecipies
                print("✅ Finished fetching detailed recipies")
                
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.updateTableViewAfterTimeFilter()
                    print("😋😋 about to present SearchResultVc - searchVC, Filtered Recipies count: \(RecipeFetchController.shared.filteredRecipies.count)")
                    
                    let storyboard = UIStoryboard(name: "Search", bundle: nil)
                    let searchVC = storyboard.instantiateViewController(withIdentifier: "searchStoryboardID")
                    let navigationController = UINavigationController(rootViewController: searchVC)
                    self.present(navigationController, animated: true, completion: nil)
                }
            })
        }
    }
    
    
    //MARK: - Helper Method to convert array into string
    func convertIngredientArrayToString() -> String{
        return ingredientListFromCamera.joined(separator: ", ")
    }
    
    
    //MARK: - helper function to filter by time it takes to cook diner
    func updateTableViewAfterTimeFilter(){
        RecipeFetchController.shared.filterRecipiesByTimeItTakesToMakeIt(arrayOfRecipies: RecipeFetchController.shared.recipiesWithDetail, timeItShouldTake: curentTagButtonTime, servingAmount: portionSize)
        print("🔥🔥 Portion size: \(portionSize), time: \(curentTagButtonTime)")
    }
    
    
    
    //MARK: - Present Camera Method
    func presentCamera(sourceType: UIImagePickerController.SourceType){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        present(picker, animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {return}
        imageToBeClasified.image = image
        imageToBeClasified.isHidden = false
        
        // Create JPG image data from UIImage with complresion of 0.8
        let imageData = image.jpegData(compressionQuality: 0.8)
        
        //MARK: - CloudSight Clasificsation
        cloudSightQuery = CloudSightQuery(image: imageData, atLocation: CGPoint.zero, withDelegate: self, atPlacemark: nil, withDeviceId: "device-id")
        
        cloudSightQuery.start()

        //TODO: - Replace this with view
      //  presentClasificationAlert()
    }
    
    func cloudSightQueryDidFinishUploading(_ query: CloudSightQuery!) {
        print("🔆 cloudSightQueryDidFinishUploading")
        
    }
    
    func cloudSightQueryDidFinishIdentifying(_ query: CloudSightQuery!) {
        print("🔆 cloudSightQueryDidFinishIdentifying")
        DispatchQueue.main.async {
            
            #warning ("replace this with view")
            let alert = UIAlertController(title: "Clasification", message: "\(query.name()!)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func cloudSightQueryDidFail(_ query: CloudSightQuery!, withError error: Error!) {
        print("CloudSight Failure: \(error.localizedDescription)")
        let alert = UIAlertController(title: "Clasification Unsucesfull", message: "Pleast try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }

    
    
    //MARK: - Clasification Alert
//    func presentClasificationAlert(){
//        let alert = UIAlertController(title: "(Clasification) XX% Sure", message: "If your image is not what we believe it is, we appologize, please update it below.", preferredStyle: .alert)
//        alert.addTextField { (updateTextField) in
//            updateTextField.placeholder = "enter whats in the image"
//        }
//        let cancelAction = UIAlertAction(title: "Canacel", style: .cancel) { (_) in
//            self.imageToBeClasified.isHidden = true
//        }
//        let saveAction = UIAlertAction(title: "Save", style: .default) { (_) in
//
//            //Ingredients.ingredients.append(self.curentClasificationText)
//            //TODO: Use current clasification and add it to the list
//
//            guard let updatedText = alert.textFields?.first?.text else {return}
//            self.currentClassificationText = updatedText
//            //FIXME: keep in mind user may not need to update the clasification -
//            //TODO: need to add updated clasification to the list
//            //   Ingredients.ingredients.append(self.curentClasificationText)
//            self.presentUpdateSuccessFullAlert()
//        }
//        alert.addAction(cancelAction)
//        alert.addAction(saveAction)
//        present(alert, animated: true)
//    }
    
    
//    func presentUpdateSuccessFullAlert() {
//        let alert = UIAlertController(title: "Ingrediten On Hand Updated", message: "What would you like to do next?", preferredStyle: .alert)
//        let uploadMoreAction = UIAlertAction(title: "Upload More", style: .default) { (_) in
//            self.presentCamera(sourceType: .camera)
//        }
//        let goToSearchAction = UIAlertAction(title: "Go To Search", style: .default) { (_) in
//            //TODO: go to search VC
//
//            //causes singabrt
//            //            guard let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "SearchFilter") else {return}
//            //            //destinationVC = SearchFilterVC()
//            //            self.present(destinationVC, animated: true, completion: nil)
//            //
//            //
//            self.imageToBeClasified.isHidden = true
//
//        }
//        alert.addAction(goToSearchAction)
//        alert.addAction(uploadMoreAction)
//        present(alert, animated: true)
//    }
//
    //MARK: - Actions
    @IBAction func addBtnTapped(_ sender: Any) {
        count = count + 1
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: count-1, section: 0), at: .bottom, animated: true)
    }
    
    @IBAction func cameraButtonTapped(_ sender: Any) {
        if  UIImagePickerController.isSourceTypeAvailable(.camera) {
            presentCamera(sourceType: .camera)
        }
    }
}

