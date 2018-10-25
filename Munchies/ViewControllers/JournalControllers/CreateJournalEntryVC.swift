//
//  CreateJournalEntryVC.swift
//  Munchies
//
//  Created by Quinten Smith on 10/17/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class CreateJournalEntryVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var entryImageView: UIImageView!
    @IBOutlet weak var enterTitleTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var cameraButton: UIButton!
    
    var user: User?
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        user = UserController.shared.loggedInUser
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        enterTitleTextField.text = ""
        notesTextView.text = "notes..."
        #warning ("set the image to a default")
    }
    
    
    //MARK: - Actions
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil) 
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = enterTitleTextField.text, title != "" else { return}
        guard let image = entryImageView.image else {return}
        EntryController.shared.createEntryWith(user: user!, image: image, title: title, description: notesTextView.text) { (entry) in
    
        }
        self.dismiss(animated: true, completion: nil)
        //  navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            presentPhotoPicker(sourceType: .photoLibrary)
            return
        }
        let photoSourcePicker = UIAlertController()
        let takePhotoAction = UIAlertAction(title: "Take Photo", style: .default) { (_) in
            self.presentPhotoPicker(sourceType: .camera)
            
        }
        let choosePhotoAction = UIAlertAction(title: "Choose Photo", style: .default) { (_) in
            self.presentPhotoPicker(sourceType: .photoLibrary)
        }
        photoSourcePicker.addAction(takePhotoAction)
        photoSourcePicker.addAction(choosePhotoAction)
        photoSourcePicker.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(photoSourcePicker, animated: true, completion: nil)
    }
    
    func presentPhotoPicker(sourceType: UIImagePickerController.SourceType){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {return}
        entryImageView.image = image
        self.cameraButton.isHidden = true
    }
    
}
