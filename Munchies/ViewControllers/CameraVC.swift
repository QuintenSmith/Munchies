//
//  CameraVC.swift
//  Munchies
//
//  Created by Quinten Smith on 10/12/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class CameraVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    //show camera
    //take a picture
    //run the clasification
    //get results
    // inform the user of the result - able to correct them
    // add the to the list
    
    
    //MARK: - Properties
    var curentClasificationText: String = ""
    
    
    //MARK: - Outlets
    @IBOutlet weak var imageToBeClassified: UIImageView!
    
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        if  UIImagePickerController.isSourceTypeAvailable(.camera) {
            presentCamera(sourceType: .camera)
        }
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
        imageToBeClassified.image = image
        
        //TODO: - Run the clasification
        
        // Create JPG image data from UIImage with complresion of 0.8
        let imageData = image.jpegData(compressionQuality: 0.8)
        
        
        presentClasificationAlert()
    }
    
//    //cameraSegue
 //   func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        let segue = UIStoryboardSegue(identifier: "cameraSegue", source: sideMenuVC(), destination: sideMenuVC())
//        if segue.identifier == "cameraSegue" {
//       unwind(for: segue , towards: sideMenuVC())
//        }
       // dismiss(animated: true, completion: nil)
      //  self.navigationController?.dismiss(animated: true, completion: nil)
    //self.dismiss(animated: true)
      //  goBack()
        //backBtnTapped(picker)
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        #warning ("need to dismis the curent view Controller when user presses cancel on camera")
//
//
//    }


    
    
    //MARK: - Actions
    @IBAction func backBtnTapped(_ sender: Any) {
        goBack()
    }
    
    func goBack(){
        self.dismiss(animated: true) {
        }
    }
    
    
    //MARK: - Clasification Alert
    func presentClasificationAlert(){
        let alert = UIAlertController(title: "(Clasification) XX% Sure", message: "If your image is not what we believe it is, we appologize, please update it below.", preferredStyle: .alert)
        alert.addTextField { (updateTextField) in
            updateTextField.placeholder = "enter whats in the image"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { (_) in
            
            //Ingredients.ingredients.append(self.curentClasificationText)
            //TODO: Use current clasification and add it to the list
            
            guard let updatedText = alert.textFields?.first?.text else {return}
            self.curentClasificationText = updatedText
            //FIXME: keep in mind user may not need to update the clasification -
            //TODO: need to add updated clasification to the list
         //   Ingredients.ingredients.append(self.curentClasificationText)
            self.presentUpdateSuccessFullAlert()
        }
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        present(alert, animated: true)
    }
    
    
    func presentUpdateSuccessFullAlert() {
        let alert = UIAlertController(title: "Ingrediten On Hand Updated", message: "What would you like to do next?", preferredStyle: .alert)
        let uploadMoreAction = UIAlertAction(title: "Upload More", style: .default) { (_) in
            self.presentCamera(sourceType: .camera)
        }
        let goToSearchAction = UIAlertAction(title: "Go To Search", style: .default) { (_) in
            //TODO: go to search VC
            
            //causes singabrt
//            guard let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "SearchFilter") else {return}
//            //destinationVC = SearchFilterVC()
//            self.present(destinationVC, animated: true, completion: nil)
//            
//            
            
            
        }
        alert.addAction(goToSearchAction)
        alert.addAction(uploadMoreAction)
        
        present(alert, animated: true)
    }
    
    

    
    
}
