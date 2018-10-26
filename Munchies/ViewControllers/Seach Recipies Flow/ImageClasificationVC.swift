//
//  ImageClasificationVC.swift
//  Munchies
//
//  Created by Kamil Wrobel on 10/20/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit
import CloudSight

class ImageClasificationVC: UIViewController, CloudSightQueryDelegate, UITextFieldDelegate {
    
    
    //MARK: - Outlets
    @IBOutlet weak var imageToBeClasifiedView: UIImageView!
    @IBOutlet weak var clasificationLabel: UILabel!
    @IBOutlet weak var clasificationCorectionTextField: UITextField!
    @IBOutlet weak var clasificationView: UIView!
    @IBOutlet weak var ClasificationViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var noButtonOutlet: RoundedShapeButton!
    @IBOutlet weak var yesButtonOutlet: RoundedShapeButton!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    //MARK: - Property
    var cloudSightQuery : CloudSightQuery!
    var keyboardHeight: CGFloat = 0
    var currentClassificationText: String = ""
    
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        clasificationCorectionTextField.delegate = self
        clasificationCorectionTextField.isHidden = true
        blurView.isHidden = true
        blurView.layer.cornerRadius = 50
        ClasificationViewHeightConstraint.constant = 0
        
        //MARK: - Gets Api Key and assigns it.
        CloudSightConnection.sharedInstance().consumerKey = RecipeFetchController.shared.getApiKey(named: "cloudSightKey")
        CloudSightConnection.sharedInstance().consumerSecret = RecipeFetchController.shared.getApiKey(named: "cloudSightSecret")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadViewIfNeeded()
        updateViews()
        
        //listen for keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    //MARK: - Keyboard Logic to move the view up.
    deinit {
        //Stop lostening for keyboard events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillChange(notification: Notification){
        print("Keyboard will show: \(notification.name.rawValue)")
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
        }
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
            view.frame.origin.y = -keyboardHeight
        } else {
            view.frame.origin.y = 0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text,
            text != "" {
            currentClassificationText = text
            ImageClasificationController.shared.clasifications.append(currentClassificationText)
            self.dismiss(animated: true, completion: nil)
        }
        
        clasificationCorectionTextField.resignFirstResponder()
        print("keaboard should be hidden now")
        
        return true
    }
    
    
    //MARK: - Actions
    @IBAction func noButtonPressed(_ sender: Any) {
        noButtonOutlet.isHidden = true
        yesButtonOutlet.isHidden = true
        clasificationCorectionTextField.isHidden = false
        clasificationLabel.text = "Please tell us what it is so we can improve your expirience."
        clasificationLabel.font = UIFont.systemFont(ofSize: 12)
        clasificationCorectionTextField.becomeFirstResponder()
    }
    
    
    @IBAction func yesButtonPressed(_ sender: Any) {
        //may need to format the clasification text before apending it tomthe array.
        ImageClasificationController.shared.clasifications.append(currentClassificationText)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    //MARK: - Helper Methods
    func updateViews() {
        guard let imageToBeClasified = ImageClasificationController.shared.curentImageAndClasification else {return}
        imageToBeClasifiedView.image = imageToBeClasified
        activityIndicator.startAnimating()
        #warning ("uncoment this two lines to run image clasification")
        // blurView.isHidden = false
        // clasifyImage(image: imageToBeClasified)
        //coment this out or delete:
        self.ClasificationViewHeightConstraint.constant = 100
    }
    
    func clasifyImage(image: UIImage){
        let imageData = image.jpegData(compressionQuality: 0.8)
        cloudSightQuery = CloudSightQuery(image: imageData, atLocation: CGPoint.zero, withDelegate: self, atPlacemark: nil, withDeviceId: "device-id")
        cloudSightQuery.start()
    }
    
    //MARK: - Cloud Sight Delegate Methods
    func cloudSightQueryDidFinishUploading(_ query: CloudSightQuery!) {
        print("🔆 cloudSight Query Did Finish Uploading")
        
    }
    
    func cloudSightQueryDidFinishIdentifying(_ query: CloudSightQuery!) {
        print("🔆 cloud Sight Query Did Finish Identifying")
        DispatchQueue.main.async {
            self.blurView.isHidden = true
            guard let clasificationText = query.name() else {return}
            self.currentClassificationText = clasificationText
            self.clasificationLabel.text = "Is this \(clasificationText)?"
            UIView.animate(withDuration: 1.0, animations: {
                self.ClasificationViewHeightConstraint.constant = 100
            })
        }
    }
    
    
    func cloudSightQueryDidFail(_ query: CloudSightQuery!, withError error: Error!) {
        print("CloudSight Failure: \(error.localizedDescription)")
        let alert = UIAlertController(title: "Clasification Unsucesfull", message: "Pleast try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
}
